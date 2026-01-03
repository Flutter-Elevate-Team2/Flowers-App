import 'package:flowers_app/Features/products/presentation/widgets/product_search_field.dart';
import 'package:flowers_app/Features/products/presentation/widgets/search_filter_button.dart';
import 'package:flutter/material.dart';

class SearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<bool>? onFocusChange;
  final VoidCallback onFilterTap;
  final ValueChanged<String>? onSubmitted;

  const SearchAndFilterBar({
    super.key,
    required this.searchController,
    required this.onFocusChange,
    required this.onFilterTap,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Focus(
              onFocusChange: (focused) {
                if (onFocusChange != null) onFocusChange!(focused);
              },
              child: ProductSearchField(
                searchController: searchController,
                onSubmitted: onSubmitted,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SearchFilterButton(onFilterTap: onFilterTap),
        ],
      ),
    );
  }
}
