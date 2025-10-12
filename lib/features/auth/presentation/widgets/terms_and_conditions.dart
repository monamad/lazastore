import 'package:flutter/material.dart';
import 'package:lazastore/core/themes/text_styles.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'By connecting your account confirm that you agree with our ',
        style: MyTextStyles.gray15Normal,
        children: [
          TextSpan(
            text: 'Term and Condition',
            style: MyTextStyles.gray15Normal.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
