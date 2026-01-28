import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/utils/json_helpers/json_keys.dart';
import '../../../../core/utils/json_helpers/json_loader.dart';
import '../../data/models/generic_section_model.dart';
import '../widgets/generic_widget.dart';

class AboutUsScreen extends StatelessWidget {
  final String locale;
  const AboutUsScreen({super.key, this.locale = JsonKeys.en});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return FutureBuilder<Map<String, dynamic>>(
      future: loadJson("assets/json/Flowery About Section JSON with Expanded Content.json"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text(context.l10n.notFoundError));
        }

        if (snapshot.hasError) {
          return Center(child: Text(context.l10n.unknownError));
        }

        final data = snapshot.data!;
        final sectionsJsonRaw = data[JsonKeys.terms];
        final sectionsJson = sectionsJsonRaw is List ? sectionsJsonRaw : null;

        if (sectionsJson == null) {
          return Center(child: Text(context.l10n.notFoundError));
        }

        final sections =
        sectionsJson.map((e) => GenericSectionModel.fromJson(e)).toList();

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: const EdgeInsetsDirectional.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: sections
                    .map((section) => buildGenericSection(section, locale))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
