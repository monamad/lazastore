import 'package:flutter/material.dart';
import 'package:lazastore/core/ui_helper/app_widgets/app_text_form_field.dart';
import 'package:lazastore/core/ui_helper/validation_helper.dart';
import 'package:lazastore/core/themes/colors.dart';
import 'package:lazastore/core/themes/text_styles.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Password', style: MyTextStyles.black16Normal),
        const SizedBox(height: 12),
        AppTextFormField(
          hintText: '••••••••••••',
          controller: widget.controller,
          isPassword: _obscurePassword,
          validator: ValidationHelper.validatePassword,
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: AppColors.gray,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
