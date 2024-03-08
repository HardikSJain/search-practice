part of 'search_bloc.dart';

@immutable
class HomeState {}

final class HomeInitial extends HomeState {}

class GetOptionsSuccess extends HomeState {
  final List<String> options;

  GetOptionsSuccess(this.options);
}

class GetOptionsDataSuccess extends HomeState {
  final List<Map<String, dynamic>> optionsData;

  GetOptionsDataSuccess(this.optionsData);
}

class SearchSuccess extends HomeState {
  final List<Map<String, dynamic>> optionsData;

  SearchSuccess(this.optionsData);
}
