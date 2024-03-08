part of 'search_bloc.dart';

@immutable
class HomeEvent {}

class GetOptionsEvent extends HomeEvent {}

class GetOptionsDataEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  String query;
  SearchEvent(this.query);
}
