import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/filter_action_button.dart';
import 'package:flowers_app/Features/products/presentation/widgets/sort_by_item.dart';
import 'package:flowers_app/Features/products/presentation/widgets/sort_option.dart';
import 'package:flowers_app/Features/products/presentation/widgets/sort_title.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SortBy extends StatefulWidget {
  final ProductsViewModel viewModel;
  const SortBy(this.viewModel, {super.key});

  @override
  State<SortBy> createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  SortOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    final Map<SortOption, String> options = {
      SortOption.lowestPrice: context.l10n.lowestPrice,
      SortOption.highestPrice: context.l10n.highestPrice,
      SortOption.newest: context.l10n.newest,
      SortOption.oldest: context.l10n.oldest,
      SortOption.discount: context.l10n.discount,
    };

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SortTitle(),
          const SizedBox(height: 16),
          ...options.entries.map((entry) {
            final option = entry.key;
            final label = entry.value;

            return SortByItem(
              label: label,
              option: option,
              selectedOption: selectedOption,
              onTap: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            );
          }),
          const SizedBox(height: 16),
          FilterActionButton(
            onPressed: () {
              if (selectedOption != null) {
                widget.viewModel.doIntent(
                  FetchProductsEvent(sort: selectedOption!.value),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
