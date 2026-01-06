enum SortOption {
  lowestPrice('priceAfterDiscount'),
  highestPrice('-priceAfterDiscount'),
  newest('new'),
  oldest('old'),
  discount('-discount');

  final String value;

  const SortOption(this.value);
}
