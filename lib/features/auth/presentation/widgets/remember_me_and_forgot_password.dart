import 'package:flutter/material.dart';
import 'package:lazastore/core/themes/text_styles.dart';
import 'package:lazastore/features/auth/presentation/widgets/remember_me_checkbox.dart';

class RememberMeAndForgotPassword extends StatefulWidget {
  final ValueChanged<bool>? onRememberMeChanged;

  const RememberMeAndForgotPassword({super.key, this.onRememberMeChanged});

  @override
  State<RememberMeAndForgotPassword> createState() =>
      _RememberMeAndForgotPasswordState();
}

class _RememberMeAndForgotPasswordState
    extends State<RememberMeAndForgotPassword> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RememberMeCheckbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() => _rememberMe = value);
            widget.onRememberMeChanged?.call(value);
          },
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            // TODO: Navigate to forgot password screen
          },
          child: Text(
            'Forgot password?',
            style: MyTextStyles.gray15Normal.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
