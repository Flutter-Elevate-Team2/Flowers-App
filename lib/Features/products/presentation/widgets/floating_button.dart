import 'package:flowers_app/Features/products/presentation/widgets/sort_by.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 34,
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SortBy(),
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
          );
        },
        child: Text((context).l10n.filter),
      ),
    );
  }
}
