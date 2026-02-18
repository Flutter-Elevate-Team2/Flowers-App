import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Icon(
              leadingIcon,
              size: 24,
              color: titleColor ?? Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      titleColor ??
                      Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ] else
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
              ),
          ],
        ),
      ),
    );
  }
}
