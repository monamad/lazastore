import 'package:flutter/material.dart';
import 'package:lazastore/features/onboarding/view/widgets/custom_button.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool isMaleSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          isMaleSelected: isMaleSelected,
          onPressed: () {
            if (isMaleSelected) return;
            setState(() {
              isMaleSelected = true;
            });
          },
          text: "Male",
        ),
        CustomButton(
          isMaleSelected: !isMaleSelected,
          onPressed: () {
            if (!isMaleSelected) return;
            setState(() {
              isMaleSelected = false;
            });
          },
          text: "Female",
        ),
      ],
    );
  }
}
