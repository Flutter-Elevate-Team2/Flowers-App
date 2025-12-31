class MetaDataEntity {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;
  final int nextPage;
  final int prevPage;

  MetaDataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
    required this.nextPage,
    required this.prevPage,
  });
}
