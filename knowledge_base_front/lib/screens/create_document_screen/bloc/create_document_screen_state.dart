abstract class CreateDocumentScreenState {}

class CreateDocumentScreenInitial extends CreateDocumentScreenState {}

class CreateDocumentScreenLoading extends CreateDocumentScreenState {}

class CreateDocumentScreenSuccess extends CreateDocumentScreenState {}

class CreateDocumentScreenFailure extends CreateDocumentScreenState {
  final String error;
  CreateDocumentScreenFailure({required this.error});
}
