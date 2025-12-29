import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SortBy extends StatefulWidget {
  const SortBy({super.key});

  @override
  State<SortBy> createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  String selectedOption = "";

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      (context).l10n.lowestPrice,
      (context).l10n.highestPrice,
      (context).l10n.newest,
      (context).l10n.oldest,
      (context).l10n.discount,
    ];

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
          ...options.map((option) {
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
                    option,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  trailing: Radio<String>(
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
                Navigator.pop(context, selectedOption);
              },
              icon: const Icon(Icons.filter_alt),
              label: Text((context).l10n.filter),
            ),
          ),
        ],
      ),
    );
  }
}
