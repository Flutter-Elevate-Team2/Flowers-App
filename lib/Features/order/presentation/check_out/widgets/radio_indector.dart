import 'package:flutter/material.dart';

class RadioIndicator extends StatelessWidget {
  final bool selected;

  const RadioIndicator({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor,
                ),
              ),
            )
          : null,
    );
  }
}
