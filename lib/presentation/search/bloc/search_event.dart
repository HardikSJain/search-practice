part of 'search_bloc.dart';

@immutable
class HomeEvent {}

class GetOptionsEvent extends HomeEvent {}

class GetOptionsDataEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String query;
  SearchEvent(this.query);
}

class OptionSelectedEvent extends HomeEvent {
  final int index;
  OptionSelectedEvent(this.index);
}
