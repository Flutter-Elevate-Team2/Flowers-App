import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

enum SortOption {
  lowestPrice('price'),
  highestPrice('-price'),
  newest('new'),
  oldest('old'),
  discount('discount');

  final String value;

  const SortOption(this.value);
}

class SortBy extends StatefulWidget {
  final ProductsViewModel viewModel;
  const SortBy(this.viewModel,{super.key});

  @override
  State<SortBy> createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  SortOption? selectedOption ;

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
          Text(
            (context).l10n.sort,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...options.entries.map((entry) {
            final option = entry.key;
            final label = entry.value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = option;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.secondary.withAlpha(30),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    label,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  trailing: Radio<SortOption>(
                    value: option,
                    groupValue: selectedOption,

                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;

                      });
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                if (selectedOption != null) {
                  widget.viewModel.doIntent(
                    FetchProductsEvent(sort: selectedOption!.value),
                  );
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.filter_list_outlined),
              label: Text((context).l10n.filter),
            ),
          ),
        ],
      ),
    );
  }
}


