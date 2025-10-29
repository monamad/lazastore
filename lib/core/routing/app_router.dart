import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/core/Di/di_setup.dart';
import 'package:lazastore/core/routing/routes.dart';
import 'package:lazastore/features/auth/presentation/logic/login_cubit.dart';
import 'package:lazastore/features/auth/presentation/view/login_view.dart';
import 'package:lazastore/features/home/Logic/get_categories/get_categories_cubit.dart';
import 'package:lazastore/features/home/Logic/get_product/get_product_cubit.dart';
import 'package:lazastore/features/home/presentation/view/home_view.dart';
import 'package:lazastore/features/onboarding/view/onboarding.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => locator<LoginCubit>(),
            child: const LoginView(),
          ),
        );
      case Routes.register:
        // return MaterialPageRoute(builder: (_) => RegisterView());
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Register Screen - Coming Soon')),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    GetCategoriesCubit(locator())..getCategories(),
              ),
              BlocProvider(
                create: (context) => GetProductCubit(locator())..getProducts(),
              ),
            ],
            child: const HomeView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
