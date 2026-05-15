import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CheckoutButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  /// True when the button is logically disabled (no address selected).
  bool get _isDisabled => !isLoading && onPressed == null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          // Grey when no address is selected, primary when loading (spinner).
          disabledBackgroundColor: _isDisabled
              ? const Color(0xFF878787)
              : Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
