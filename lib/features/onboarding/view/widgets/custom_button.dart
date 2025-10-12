import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazastore/core/themes/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isMaleSelected,
    required this.onPressed,
    required this.text,
  });

  final bool isMaleSelected;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 152.w,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            isMaleSelected ? AppColors.primary : Colors.grey[200],
          ),

          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: isMaleSelected ? Colors.white : AppColors.gray,

            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
