abstract class HomeScreenEvent {}

class FetchDocumentsEvent extends HomeScreenEvent {}

class SearchDocumentsEvent extends HomeScreenEvent {
  final String keyword;
  SearchDocumentsEvent({required this.keyword});
}
