import 'package:knowledge_base_front/model/DocumentModel.dart';

abstract class HomeScreenState {}

class HomeScreenInitalState extends HomeScreenState {}

class HomeScreenLoadingState extends HomeScreenState {}

class HomeScreenUserFetchedSuccessState extends HomeScreenState {
  final List<DocumentModel> documents;

  HomeScreenUserFetchedSuccessState({required this.documents});
}

class HomeScreenErrorState extends HomeScreenState {
  String error;
  HomeScreenErrorState(this.error);
}
