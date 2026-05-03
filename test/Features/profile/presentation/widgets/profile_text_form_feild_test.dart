 import 'package:flowers_app/Features/profile/presentation/widgets/profile_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    required String label,
    String? initialValue,
    bool isObscure = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
           child: ProfileTextField(
            label: label,
            initialValue: initialValue,
            isObscure: isObscure,
            controller: controller,
            validator: validator,
            readOnly: readOnly,
          ),
        ),
      ),
    );
  }

  testWidgets('Should display the correct label text', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(label: 'Email'));
    expect(find.text('Email'), findsOneWidget);
  });

  testWidgets('Should show initial value when no controller is provided', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      label: 'Name',
      initialValue: 'Ahmed',
    ));
    expect(find.text('Ahmed'), findsOneWidget);
  });

  testWidgets('Should respect readOnly property', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      label: 'ID',
      initialValue: '123',
      readOnly: true,
    ));

     final TextField textField = tester.widget<TextField>(find.byType(TextField));

     expect(textField.readOnly, isTrue);
  });

  testWidgets('Should obscure text when isObscure is true', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      label: 'Password',
      isObscure: true,
    ));

     final TextField textField = tester.widget<TextField>(find.byType(TextField));

    expect(textField.obscureText, isTrue);
  });
   testWidgets('Should trigger validation and show error message', (tester) async {
    const String errorText = 'Field cannot be empty';

    await tester.pumpWidget(createWidgetUnderTest(
      label: 'Username',
      validator: (value) => value!.isEmpty ? errorText : null,
    ));

     final FormState form = tester.state(find.byType(Form));
    form.validate();
    await tester.pump();

    expect(find.text(errorText), findsOneWidget);
  });

  testWidgets('Should update text through controller', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(createWidgetUnderTest(
      label: 'Input',
      controller: controller,
    ));

    await tester.enterText(find.byType(TextFormField), 'Hello Flutter');
    expect(controller.text, 'Hello Flutter');
  });
}