import 'package:flutter/material.dart';

class DefaultTabBar extends StatelessWidget {
  final List<String> tabs;
  final ValueChanged<int>? onTap;
  final TabController? controller;

  const DefaultTabBar( this.tabs ,{super.key, this.onTap, this.controller, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TabBar(
        controller: controller,
          onTap: onTap,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          unselectedLabelColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.label ,
          tabs: tabs.map((title) => Tab(text: title)).toList(),
          dividerColor: Theme.of(context).colorScheme.onPrimary.withAlpha(0),
      ),
    );
  }
}
