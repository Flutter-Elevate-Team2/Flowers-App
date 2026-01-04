import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/search_and_filter/sort_by.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/shared/floating_button_content.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  final ProductsViewModel viewModel;

  const FloatingButton(this.viewModel, {super.key});

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
        onPressed: () async {
          showModalBottomSheet<String>(
            context: context,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.onPrimary.withValues(alpha: 0),
            isScrollControlled: true,
            builder: (context) => SortBy(widget.viewModel),
          );
        },
        child: const FloatingButtonContent(),
      ),
    );
  }
}
