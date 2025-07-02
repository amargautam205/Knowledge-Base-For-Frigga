import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/create_document_screen/bloc/create_document_screen_event.dart';
import 'package:knowledge_base_front/screens/create_document_screen/bloc/create_document_screen_state.dart';
import 'package:knowledge_base_front/screens/create_document_screen/create_document_screen_presenter.dart';

class CreateDocumentScreenBloc
    extends Bloc<CreateDocumentScreenEvent, CreateDocumentScreenState> {
  CreateDocumentScreenBloc() : super(CreateDocumentScreenInitial()) {
    on<CreateDocumentButtonPressed>(_onCreateDocumentButtonPressed);
  }

  void _onCreateDocumentButtonPressed(CreateDocumentButtonPressed event,
      Emitter<CreateDocumentScreenState> emit) async {
    try {
      emit(CreateDocumentScreenLoading());
      await CreateDocumentScreenPresenter.createDocument(
          event.title, event.content, event.isPublic);
      emit(CreateDocumentScreenSuccess());
    } catch (e) {
      print("Exception occuring from here."+ e.toString());
      emit(CreateDocumentScreenFailure(
          error: e.toString().replaceAll("Exception: ", "")));
    }
  }
}
