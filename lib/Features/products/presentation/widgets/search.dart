import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final  ValueChanged<bool>? onFocusChange;
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

    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child:  Focus(
                onFocusChange: (focused) {
                  if (onFocusChange != null) onFocusChange!(focused);
                },
                child: TextField(
                controller: searchController,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  hintText: (context).l10n.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color:Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color:Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4)),
                  ),
                ),
              ),
            ),
        ),
            const SizedBox(width: 12),
            Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4)),
                  ),
                  child: const Icon(Icons.filter_list_outlined),
                )
            ),
          ],
        ),
    );
  }
  }
