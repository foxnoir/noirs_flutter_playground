import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/widgets/add_user_text_field.dart';

void main() {
  testWidgets('AddUserTextField shows the label and uses the controller', (
    tester,
  ) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            child: AddUserTextField(
              controller: controller,
              label: 'Username',
              validator: (_) => null,
            ),
          ),
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'Ada',
    );

    expect(controller.text, 'Ada');
  });
}
