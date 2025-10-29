import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazastore/core/di/di_setup.dart';
import 'package:lazastore/core/routing/app_router.dart';
import 'package:lazastore/core/routing/routes.dart';
import 'package:lazastore/features/app_controller/logic/app_controller_cubit.dart';
import 'package:lazastore/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    BlocProvider<AppControllerCubit>(
      create: (context) => locator<AppControllerCubit>()..checkAuthStatus(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocBuilder<AppControllerCubit, AppControllerState>(
        builder: (context, state) {
          if (state is Initial) {
            return const SizedBox.shrink();
          } else {
            final initialRoute = switch (state) {
              Authenticated() => Routes.home,
              Unauthenticated() => Routes.onboarding,
              AuthError() => Routes.onboarding,
              _ => Routes.onboarding,
            };
            FlutterNativeSplash.remove();

            return MaterialApp(
                          localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,

              title: 'LazaStore',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: initialRoute,
              // home: TestWidget(),
            );
          }
        },
      ),
    );
  }
}
// m011415145@gmail.com

// class TestWidget extends StatelessWidget {
//   final ValueNotifier<bool> showBox = ValueNotifier<bool>(false);
//   TestWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ValueListenableBuilder<bool>(
//           valueListenable: showBox,
//           builder: (context, isDrawerOpen, child) {
//             return showBox.value == true
//                 ? Container(color: Colors.green, child: child)
//                 : Container(child: child);
//           },
//           child: Column(
//             key: const Key('column_child'),
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Builder(
//                 builder: (context) {
//                   print('Building TestWidget');
//                   return Text('Test Widget', style: TextStyle(fontSize: 24.sp));
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   showBox.value = !showBox.value;
//                 },
//                 child: const Text('Toggle Box'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
