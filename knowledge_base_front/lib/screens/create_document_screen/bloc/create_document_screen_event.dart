abstract class CreateDocumentScreenEvent {}

class CreateDocumentButtonPressed extends CreateDocumentScreenEvent {
  final String title;
  final String content; // JSON-encoded Delta string
  final bool isPublic;

  CreateDocumentButtonPressed({
    required this.title,
    required this.content,
    required this.isPublic,
  });
}
