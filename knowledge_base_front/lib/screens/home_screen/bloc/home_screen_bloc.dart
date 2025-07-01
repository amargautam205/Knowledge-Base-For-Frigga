import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/model/DocumentModel.dart';
import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_event.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_state.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitalState()) {
    on<FetchDocumentsEvent>(_onFetchDocuments);
    on<SearchDocumentsEvent>(_onSearchDocuments);
  }

  Future<void> _onFetchDocuments(
      FetchDocumentsEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoadingState());

    try {
      emit(HomeScreenLoadingState());

      final myResponse =
          await ApiRepository.getAPI(endpoint: ApiConst.getMyDocuments);
      final publicResponse =
          await ApiRepository.getAPI(endpoint: ApiConst.getPublicDocuments);

      final myDocs = (myResponse.data['data'] as List)
          .map((e) => DocumentModel.fromJson(e))
          .toList();

      final publicDocs = (publicResponse.data['data'] as List)
          .map((e) => DocumentModel.fromJson(e))
          .toList();

      final mergedDocs = [...myDocs, ...publicDocs];

      emit(HomeScreenUserFetchedSuccessState(documents: mergedDocs));
    } catch (e) {
      emit(HomeScreenErrorState(e.toString()));
    }
  }

  Future<void> _onSearchDocuments(
      SearchDocumentsEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoadingState());
    try {
      final response = await ApiRepository.getAPI(
        endpoint: '${ApiConst.searchDocument}?keyword=${event.keyword}',
      );

      final List<dynamic> data = response.data['data'];
      final List<DocumentModel> documents =
          data.map((json) => DocumentModel.fromJson(json)).toList();

      emit(HomeScreenUserFetchedSuccessState(documents: documents));
    } catch (e) {
      emit(HomeScreenErrorState(e.toString()));
    }
  }
}
