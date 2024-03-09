import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:temp/domain/usecases/search_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<HomeEvent, HomeState> {
  final SearchUseCase _searchUseCase;

  SearchBloc(this._searchUseCase) : super(HomeInitial()) {
    on<GetOptionsEvent>(_getOptionsEvent);
    on<GetOptionsDataEvent>(_getOptionsData);
    on<SearchEvent>(_searchEvent);
    on<OptionSelectedEvent>(_optionSelectedEvent);
  }

  _getOptionsEvent(GetOptionsEvent event, Emitter<HomeState> emit) async {
    final List<String> options = await _searchUseCase.getOptions();
    emit(GetOptionsSuccess(options));
  }

  _getOptionsData(GetOptionsDataEvent event, Emitter<HomeState> emit) async {
    final List<Map<String, dynamic>> optionsData =
        await _searchUseCase.getOptionsData();
    emit(GetOptionsDataSuccess(optionsData));
  }

  _searchEvent(SearchEvent event, Emitter<HomeState> emit) async {
    final List<Map<String, dynamic>> optionsData =
        await _searchUseCase.getOptionsData();
    final List<Map<String, dynamic>> filteredOptionsData = optionsData
        .where((element) =>
            element['heading']
                .toLowerCase()
                .contains(event.query.toLowerCase()) ||
            element['subheading']
                .toLowerCase()
                .contains(event.query.toLowerCase()))
        .toList();
    emit(SearchSuccess(filteredOptionsData));
  }

  _optionSelectedEvent(
      OptionSelectedEvent event, Emitter<HomeState> emit) async {
    final List<String> options = await _searchUseCase.getOptions();

    String selectedOption = options[event.index];

    final List<Map<String, dynamic>> optionsData =
        await _searchUseCase.getOptionsData();

    if (event.index == 0) {
      return emit(OptionSelectedSuccess(optionsData));
    }

    final List<Map<String, dynamic>> filteredOptionsData = optionsData
        .where((element) => element['category'] == selectedOption)
        .toList();

    emit(OptionSelectedSuccess(filteredOptionsData));
  }
}
