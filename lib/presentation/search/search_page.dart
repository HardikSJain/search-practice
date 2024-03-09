import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:temp/domain/usecases/search_use_case.dart';
import 'package:temp/presentation/common/svg_constants.dart';
import 'package:temp/presentation/search/bloc/search_bloc.dart';
import 'package:temp/presentation/search/widgets/search_app_bar.dart';
import 'package:temp/presentation/widgets/custom_sliver_appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc _searchBloc;
  late SearchUseCase _searchUseCase;
  late RefreshController _refreshController;

  bool isOptionsLoading = true;
  bool isOptionsDataLoading = true;

  List<String> options = [];

  List<Map<String, dynamic>> optionsData = [];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchUseCase = SearchUseCase();
    _searchBloc = SearchBloc(_searchUseCase);
    _searchBloc.add(GetOptionsEvent());
    _searchBloc.add(GetOptionsDataEvent());
    _refreshController = RefreshController();
  }

  _listener(BuildContext context, HomeState state) {
    if (state is GetOptionsSuccess) {
      setState(() {
        options = state.options;
      });
    }
    if (state is GetOptionsDataSuccess) {
      setState(() {
        optionsData = state.optionsData;
      });
      // print(optionsData);
    }
    if (state is SearchSuccess) {
      setState(() {
        optionsData = state.optionsData;
      });
    }
    if (state is OptionSelectedSuccess) {
      setState(() {
        optionsData = state.filteredOptionsData;
      });
    }
  }

  changeOption(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  onOptionSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    _searchBloc.add(OptionSelectedEvent(index));
  }

  onSearch(String value) {
    _searchBloc.add(SearchEvent(value));
  }

  // function to return sliced string
  String sliceString(String string) {
    return string.length > 30 ? '${string.substring(0, 30)}...' : string;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 26, 42, 1),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer(
        bloc: _searchBloc,
        listener: _listener,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  enablePullUp: true,
                  physics: const BouncingScrollPhysics(),
                  child: CustomScrollView(
                    slivers: [
                      CustomSliverAppBar.widgetWrapper(
                          context: context,
                          child: SearchHeader(
                            onOptionSelected: onOptionSelected,
                            changeOption: changeOption,
                            options: options,
                            selectedIndex: selectedIndex,
                            onSearch: onSearch,
                          )),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  color: const Color.fromRGBO(42, 33, 54, 1),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      217, 217, 217, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // image
                                                )),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  sliceString(optionsData[index]
                                                      ['heading']),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  sliceString(optionsData[index]
                                                      ['subheading']),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            optionsData[index]['isBookmarked'] =
                                                !optionsData[index]
                                                    ['isBookmarked'];

                                            // api call
                                          });
                                        },
                                        icon: SvgPicture.asset(
                                          optionsData[index]['isBookmarked']
                                              ? SvgConstants.bookmarkFilled
                                              : SvgConstants.bookmarkHollow,
                                          height: 20,
                                          width: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: optionsData.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
