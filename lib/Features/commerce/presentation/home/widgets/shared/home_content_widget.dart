import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/sections/home_section_factory.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_events.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContentWidget extends StatelessWidget {
  final HomeEntity homeData;

  const HomeContentWidget({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenHeight = constraints.maxHeight;
        final double screenWidth = constraints.maxWidth;

        final sections = HomeSectionFactory.getSections(
          data: homeData,
          context: context,
        );

        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeViewModel>().doIntent(GetHomeDataEvent());
            },
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...sections.expand(
                              (widget) => [
                            widget,
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                        if (sections.isEmpty)
                          const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
