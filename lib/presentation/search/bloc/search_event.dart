part of 'search_bloc.dart';

@immutable
class HomeEvent {}

class GetOptionsEvent extends HomeEvent {}

class GetOptionsDataEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String query;
  final List<Map<String, dynamic>> optionsData;
  SearchEvent(this.query, this.optionsData);
}

class OptionSelectedEvent extends HomeEvent {
  final int index;
  final List<String> options;
  final List<Map<String, dynamic>> optionsData;
  OptionSelectedEvent(this.index, this.options, this.optionsData);
}
