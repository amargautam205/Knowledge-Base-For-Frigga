class DocumentModel {
  final int id;
  final String title;
  final String content;
  final String authorEmail;
  final String createdAt;
  final String lastModifiedAt;
  final bool isPublic;

  DocumentModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorEmail,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.isPublic,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      authorEmail: json['authorEmail'],
      createdAt: json['createdAt'],
      lastModifiedAt: json['lastModifiedAt'],
      isPublic: json['is_public'],
    );
  }
}
