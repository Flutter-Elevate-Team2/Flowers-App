import 'package:flutter/material.dart';

class CheckOutSectionWrapper extends StatelessWidget {
  final Widget child;

  const CheckOutSectionWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: child,
    );
  }
}
