import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/ui_helper/custom_app_bar.dart';
import 'package:lazastore/core/routing/routes.dart';
import 'package:lazastore/core/themes/text_styles.dart';
import 'package:lazastore/features/auth/presentation/logic/login_cubit.dart';
import 'package:lazastore/features/auth/presentation/logic/login_state.dart';
import 'package:lazastore/features/auth/presentation/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: _handleLoginState,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomAppBar(
                      leadingIcon: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black,
                      ),
                      onLeadingTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text('Welcome', style: MyTextStyles.black32Bold),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your data to continue',
                    style: MyTextStyles.gray15Normal,
                  ),
                  const SizedBox(height: 50),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    switch (state) {
      case LoginSuccess():
        Navigator.pushReplacementNamed(context, Routes.home);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        break;

      case LoginFailure():
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message), backgroundColor: Colors.red),
        );
        break;
      default:
        break;
    }
  }
}
