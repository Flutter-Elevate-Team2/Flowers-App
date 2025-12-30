import 'package:flutter/material.dart';

class DefaultTabBar extends StatelessWidget {
  final List<String> tabs;

  const DefaultTabBar( this.tabs ,{super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        unselectedLabelColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label ,
        tabs: tabs.map((title) => Tab(text: title)).toList(),
        dividerColor: Colors.transparent,
      ),
    );
  }
}
