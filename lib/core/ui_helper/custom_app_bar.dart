import 'package:flutter/material.dart';
import 'package:lazastore/core/ui_helper/app_widgets/custom_circler_background.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? centerTitle;
  final Widget? leadingIcon;
  final VoidCallback onLeadingTap;
  final Color widgetsBackgroundColor;

  final Widget? action;
  final VoidCallback? onActionTap;

  const CustomAppBar({
    super.key,
    this.centerTitle,
    required this.onLeadingTap,
    this.action,
    this.onActionTap,
    this.leadingIcon,
    this.widgetsBackgroundColor = const Color(0xffF5F6FA),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onLeadingTap,
          child: CustomCircularBackground(
            backgroundColor: widgetsBackgroundColor,
            child:
                leadingIcon ??
                const Icon(Icons.arrow_back, size: 20, color: Colors.black),
          ),
        ),
        (centerTitle != null) ? centerTitle! : const SizedBox(),
        (action != null)
            ? CustomCircularBackground(
                backgroundColor: widgetsBackgroundColor,
                child: GestureDetector(onTap: onActionTap, child: action),
              )
            : const SizedBox(),
      ],
    );
  }
}
