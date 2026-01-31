class GenericSectionModel {
  final String section;
  final String? titleEn;
  final String? titleAr;
  final dynamic contentEn;
  final dynamic contentAr;
  final Map<String, dynamic> style;
  final Map<String, dynamic>? titleStyle;

  GenericSectionModel({
    required this.section,
    this.titleEn,
    this.titleAr,
    required this.contentEn,
    required this.contentAr,
    required this.style,
    this.titleStyle,
  });

  factory GenericSectionModel.fromJson(Map<String, dynamic> json) {
    final style = (json['style'] as Map?)?.cast<String, dynamic>() ?? {};
    final titleJson = json['title'] as Map<String, dynamic>?;
    final contentJson = json['content'] as Map<String, dynamic>?;

    return GenericSectionModel(
      section: json['section'] as String? ?? "",
      titleEn: titleJson?['en'] as String?,
      titleAr: titleJson?['ar'] as String?,
      contentEn: contentJson?['en'],
      contentAr: contentJson?['ar'],
      style: style,
      titleStyle: (style['title'] as Map?)?.cast<String, dynamic>(),
    );
  }

}