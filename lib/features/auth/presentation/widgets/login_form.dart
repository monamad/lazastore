import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/ui_helper/app_widgets/app_primary_button.dart';
import 'package:lazastore/features/auth/presentation/logic/login_cubit.dart';
import 'package:lazastore/features/auth/presentation/logic/login_state.dart';
import 'package:lazastore/features/auth/presentation/widgets/password_field.dart';
import 'package:lazastore/features/auth/presentation/widgets/remember_me_and_forgot_password.dart';
import 'package:lazastore/features/auth/presentation/widgets/terms_and_conditions.dart';
import 'package:lazastore/features/auth/presentation/widgets/username_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRememberMeChanged(bool value) {
    _rememberMe = value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UsernameField(controller: _emailController),
          const SizedBox(height: 24),
          PasswordField(controller: _passwordController),
          const SizedBox(height: 24),
          RememberMeAndForgotPassword(
            onRememberMeChanged: _onRememberMeChanged,
          ),
          const SizedBox(height: 24),
          const TermsAndConditions(),
          const SizedBox(height: 40),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AppPrimaryButton(
          text: 'Login',
          onPressed: _handleLogin,
          isLoading: state is LoginLoading,
        );
      },
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );
    }
  }
}
