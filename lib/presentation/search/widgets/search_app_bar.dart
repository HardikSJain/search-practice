import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:temp/presentation/common/svg_constants.dart';

class SearchHeader extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onOptionSelected;
  final Function(int) changeOption;
  final Function(String) onSearch;

  const SearchHeader({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
    required this.onSearch,
    required this.changeOption,
  });

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
    return Padding(
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
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      onSearch(value);
                      changeOption(0);
                    },
                    style: const TextStyle(
                      color: Color.fromRGBO(235, 236, 236, 1),
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          SvgConstants.search,
                          height: 8,
                          width: 8,
                        ),
                      ),
                      fillColor: const Color.fromRGBO(42, 33, 54, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintText: 'Search by Stock Name, Patterns...',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(235, 236, 236, 0.3),
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
                    onOptionSelected(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
    );
  }
}
