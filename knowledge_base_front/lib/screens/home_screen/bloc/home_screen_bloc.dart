import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/model/DocumentModel.dart';
import 'package:knowledge_base_front/repository/api_repository.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_event.dart';
import 'package:knowledge_base_front/screens/home_screen/bloc/home_screen_state.dart';
import 'package:knowledge_base_front/utils/api_const.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitalState()) {
    on<FetchDocumentsEvent>(_onFetchDocuments);
  }

  Future<void> _onFetchDocuments(
      FetchDocumentsEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoadingState());

    try {
      final response = await ApiRepository.getAPI(
        endpoint: ApiConst.getAllDocuments,
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
