import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int? prevPage;
  final int? nextPage;
  final void Function(int page) onPageSelected;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    this.prevPage,
    this.nextPage,
    this.onNext,
    this.onPrev,
  });

  List<int> _visiblePages() {
    if (totalPages <= 5) {
      return List.generate(totalPages, (i) => i + 1);
    }

    if (currentPage <= 3) {
      return [1, 2, 3, 4, 5];
    }

    if (currentPage >= totalPages - 2) {
      return [
        totalPages - 4,
        totalPages - 3,
        totalPages - 2,
        totalPages - 1,
        totalPages
      ];
    }

    return [
      currentPage - 2,
      currentPage - 1,
      currentPage,
      currentPage + 1,
      currentPage + 2,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _visiblePages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: prevPage != null ? onPrev : null,
          icon: const Icon(Icons.chevron_left),
        ),

        if (pages.first > 1) const Text("..."),

        ...pages.map(
              (page) => GestureDetector(
            onTap: () => onPageSelected(page),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: page == currentPage
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Text(
                page.toString(),
                style: TextStyle(
                  color: page == currentPage ? AppColors.white : Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        ),

        if (pages.last < totalPages) const Text("..."),

        IconButton(
          onPressed: nextPage != null ? onNext : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
