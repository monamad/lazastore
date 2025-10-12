import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazastore/core/routing/routes.dart';
import 'package:lazastore/core/themes/colors.dart';
import 'package:lazastore/core/themes/text_styles.dart';
import 'package:lazastore/features/onboarding/view/widgets/gender_selection.dart';
import 'package:lazastore/features/onboarding/view/widgets/gradient_circle.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: GradientCircle(
              width: 200,
              height: 300,
              startAlpha: 0.3,
              middleAlpha: 0.1,
            ),
          ),
          Positioned(
            bottom: -30,
            left: -80,
            child: GradientCircle(
              width: 250,
              height: 250,
              startAlpha: 0.2,
              middleAlpha: 0.05,
              middleStop: 0.6,
            ),
          ),
          Positioned(
            bottom: 150,
            right: -20,
            //left: 20,
            child: GradientCircle(
              width: 280,
              height: 280,
              startAlpha: 0.25,
              middleAlpha: 0.08,
            ),
          ),

          Image.asset("assets/images/background_image.png"),
          Positioned(
            bottom: 40,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 6, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Look Good, Feel Good",
                    style: MyTextStyles.black25SemiBold,
                  ),
                  Text(
                    "Create your individual & unique style and look amazing everyday.",
                    style: MyTextStyles.gray15Normal,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  GenderSelection(),
                  SizedBox(height: 10.h),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: Text("Skip", style: MyTextStyles.gray17Normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
