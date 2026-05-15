import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/categories_tabs_shimmer.dart';
import 'package:flutter/material.dart';

class DefaultTabBar extends StatelessWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTap;
  final TabController? controller;
  final bool isLoading;
  final int fixedTabsCount;

  const DefaultTabBar(
    this.tabs, {
    super.key,
    this.onTap,
    this.controller,
    this.isLoading = false,
    this.fixedTabsCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TabBar(
        controller: controller,
        onTap: isLoading ? null : onTap,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        unselectedLabelColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Theme.of(context).colorScheme.onPrimary.withAlpha(0),

        tabs: List.generate(tabs.length, (index) {
          final title = tabs[index];
           if (isLoading && title.isEmpty) {
            return const Tab(child: CategoriesTabsShimmer());
          }
          return Tab(text: title);
        }),
      ),
    );
  }
}
