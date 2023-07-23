abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchButtonPressedState extends SearchState {}

class SearchButtonUnpressedState extends SearchState {}

class SearchListEmptyState extends SearchState {}

class SearchListNotEmptyState extends SearchState {}

class SearchResultsState extends SearchState {
  final List<dynamic> results;

  SearchResultsState(this.results);
}