import 'package:flowers_app/Features/profile/data/models/about_model.dart';
import 'package:flowers_app/Features/profile/data/models/generic_section_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/json_helpers/parse_font_weight.dart';
import '../../../../../core/utils/json_helpers/parse_text_style.dart';
import '../../../../core/utils/json_helpers/hex_to_color.dart';

Widget buildGenericSection(GenericSectionModel section, String locale) {
  final isEn = locale == 'en';

  final title = isEn ? section.titleEn : section.titleAr;
  final content = isEn ? section.contentEn : section.contentAr;

  final titleStyleMap = section.titleStyle ?? section.style;
  final contentStyleMap = section.style['content'] ?? section.style;

  final titleStyle = TextStyle(
    fontSize: (titleStyleMap['fontSize'] as num?)?.toDouble() ?? 18,
    fontWeight: parseFontWeight(titleStyleMap['fontWeight']),
    color: hexToColor(titleStyleMap['color'] ?? "#000000"),
  );

  final contentStyle = TextStyle(
    fontSize: (contentStyleMap['fontSize'] as num?)?.toDouble() ?? 14,
    fontWeight: parseFontWeight(contentStyleMap['fontWeight']),
    color: hexToColor(contentStyleMap['color'] ?? "#333333"),
  );

  List<Widget> children = [];

  if (title != null) {
    children.add(Text(
      title,
      style: titleStyle,
      textAlign: parseTextAlign(titleStyleMap['textAlign']?[locale]),
    ));
    children.add(const SizedBox(height: 8));
  }

  if (content is String) {
    children.add(Text(
      content,
      style: contentStyle,
      textAlign: parseTextAlign(contentStyleMap['textAlign']?[locale]),
    ));
  } else if (content is List) {
    children.addAll(
      (content as List).map<Widget>(
            (paragraph) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            paragraph,
            style: contentStyle,
            textAlign: parseTextAlign(contentStyleMap['textAlign']?[locale]),
          ),
        ),
      ),
    );
  }

  return Container(
    color: hexToColor(contentStyleMap['backgroundColor'] ?? "#FFFFFF"),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}