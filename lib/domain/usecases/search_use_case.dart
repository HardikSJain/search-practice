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
      },
      {
        'heading': 'Booming Financial',
        'subheading': 'Thematic Strategy',
        'isBookmarked': false,
      },
      {
        'heading': 'Value Picker',
        'subheading': 'Fundamental Strategy',
        'isBookmarked': false,
      },
      {
        'heading': 'Strong TMT',
        'subheading': 'Long term idea',
        'isBookmarked': false,
      },
      {
        'heading': 'Vehicle Cell',
        'subheading': 'Short term idea',
        'isBookmarked': false,
      },
    ];
  }
}
