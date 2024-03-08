import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:temp/domain/usecases/search_use_case.dart';
import 'package:temp/presentation/search/bloc/search_bloc.dart';
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
  }

  Widget _options(String option, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? const Color.fromRGBO(1, 195, 109, 1)
              : const Color.fromRGBO(163, 165, 167, 1),
        ),
        borderRadius: BorderRadius.circular(10),
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF393046),
                  Color(0xFF2D2537),
                ],
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? const Color.fromRGBO(1, 195, 109, 1)
                    : const Color.fromRGBO(163, 165, 167, 1),
              ),
            ),
          ],
        ),
      ),
    );
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
                  enablePullDown: true,
                  physics: const BouncingScrollPhysics(),
                  child: CustomScrollView(
                    slivers: [
                      CustomSliverAppBar.widgetWrapper(
                        context: context,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: TextField(
                                        onChanged: (value) =>
                                            _searchBloc.add(SearchEvent(value)),
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(235, 236, 236, 1),
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "assets/svgs/search.svg",
                                              height: 8,
                                              width: 8,
                                            ),
                                          ),
                                          fillColor: const Color.fromRGBO(
                                              42, 33, 54, 1),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          hintText:
                                              'Search by Stock Name, Patterns...',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(
                                                235, 236, 236, 0.3),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 35,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: _options(
                                          options[index],
                                          index == selectedIndex,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                                  // if optionsData[index]['heading'] length is greater than 30 then it will be truncated first check the length of the string and then truncate it
                                                  optionsData[index]['heading']
                                                              .length >
                                                          30
                                                      ? optionsData[index]
                                                                  ['heading']
                                                              .substring(
                                                                  0, 30) +
                                                          '...'
                                                      : optionsData[index]
                                                          ['heading'],

                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  optionsData[index]
                                                                  ['subheading']
                                                              .length >
                                                          30
                                                      ? optionsData[index]
                                                                  ['subheading']
                                                              .substring(
                                                                  0, 30) +
                                                          '...'
                                                      : optionsData[index]
                                                          ['subheading'],
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
                                              ? "assets/svgs/bookmark_filled.svg"
                                              : "assets/svgs/bookmark_hollow.svg",
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
