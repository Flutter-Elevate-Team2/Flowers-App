import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool isObscure;
  final Widget? trailing;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const ProfileTextField({
    super.key,
    required this.label,
    this.initialValue,
    this.isObscure = false,
    this.trailing,
    this.controller,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          obscureText: isObscure,
          readOnly: readOnly,
          validator: validator,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: trailing,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
