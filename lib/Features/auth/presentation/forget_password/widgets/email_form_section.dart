import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/form_validators.dart';
import 'package:flutter/material.dart';

class EmailFormSection extends StatefulWidget {
  const EmailFormSection({super.key, required this.onNextPage});

  final VoidCallback onNextPage;

  @override
  State<EmailFormSection> createState() => _EmailFormSectionState();
}

class _EmailFormSectionState extends State<EmailFormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => FormValidators.validateEmail(context, value),
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              labelText: context.l10n.emailLabel,
              hintText: context.l10n.emailHint,
            ),
          ),
          SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                
                  widget.onNextPage();
                } else {
                  
                  setState(() {
                    _autovalidateMode = AutovalidateMode.onUserInteraction;
                  });
                }
              },
              child: Text(context.l10n.confirmButton),
            ),
          ),
        ],
      ),
    );
  }
}
