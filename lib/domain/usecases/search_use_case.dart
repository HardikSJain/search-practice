class SearchUseCase {
  Future<List<String>> getOptions() async {
    return ["All", "Ideas", "Strategies", "Stocks"];
  }

  Future<List<Map<String, dynamic>>> getOptionsData() async {
    return [
      {
        'heading': 'Trending Outliers',
        'subheading': 'Quantative Strategy',
        'isBookmarked': true,
        'category': 'Strategies',
      },
      {
        'heading': 'Booming Financial',
        'subheading': 'Thematic Strategy',
        'isBookmarked': false,
        'category': 'Strategies',
      },
      {
        'heading': 'Value Picker',
        'subheading': 'Fundamental Strategy',
        'isBookmarked': false,
        'category': 'Strategies',
      },
      {
        'heading': 'Strong TMT',
        'subheading': 'Long term idea',
        'isBookmarked': false,
        'category': 'Ideas',
      },
      {
        'heading': 'Vehicle Cell',
        'subheading': 'Short term idea',
        'isBookmarked': false,
        'category': 'Ideas',
      },
      {
        'heading':
            'Vehicle Cell overflowed overflowed overflowed overflowed overflowed',
        'subheading': 'Short term idea overflowed overflowed overflowed',
        'isBookmarked': false,
        'category': 'Ideas',
      },
    ];
  }
}
