import 'package:flutter/material.dart';
import 'package:lazastore/core/ui_helper/app_widgets/app_text_form_field.dart';
import 'package:lazastore/core/ui_helper/validation_helper.dart';
import 'package:lazastore/core/themes/text_styles.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Username', style: MyTextStyles.black16Normal),
        const SizedBox(height: 12),
        AppTextFormField(
          hintText: 'enter your user name',
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          validator: ValidationHelper.validateEmail,
        ),
      ],
    );
  }
}
