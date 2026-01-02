class MetadataEntity {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;
  final int? nextPage;
  final int? prevPage;

  MetadataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
    this.nextPage,
    this.prevPage,
  });
}
