import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazastore/core/networking/api_error.dart';
import 'package:lazastore/core/networking/api_result.dart';
import 'package:lazastore/features/auth/domain/repos/auth_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lazastore/features/auth/presentation/logic/login_cubit.dart';
import 'package:lazastore/features/auth/presentation/logic/login_state.dart';
import 'package:lazastore/features/auth/presentation/view/login_view.dart';
import 'package:lazastore/features/auth/domain/use_cases/login_use_case.dart';
import 'package:lazastore/features/auth/domain/entities/login_entity.dart';

// Mock classes
class MockLoginUseCase extends Mock implements LoginUseCase {}

// Mock data
const mockLoginEntity = LoginEntity(
  accessToken: 'mock_access_token',
  expiresAtUtc: '2025-10-08T03:08:47.982Z',
  refreshToken: 'mock_refresh_token',
);

void main() {
  group('LoginView Tests', () {
    testWidgets('should display login form elements', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      // Verify the welcome header is displayed
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Please enter your data to continue'), findsOneWidget);

      // Verify form fields are displayed
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Verify form inputs are present
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Verify remember me checkbox
      expect(find.text('Remember me'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);

      // Verify forgot password link
      expect(find.text('Forgot password?'), findsOneWidget);

      // Verify login button
      expect(find.text('Login'), findsOneWidget);

      // Verify terms and conditions text
      expect(find.textContaining('Term and Condition'), findsOneWidget);
    });

    testWidgets('should validate empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      // Tap the login button without filling fields
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Check if validation messages appear
      expect(find.text('Please enter your username/email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });
  });

  group('LoginCubit Tests', () {
    late LoginCubit loginCubit;

    setUp(() {
      final mockLoginUseCase = MockLoginUseCase();

      when(
        () => mockLoginUseCase(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((x) async {
        // Simulate success for specific credentials
        if (x.namedArguments[const Symbol('email')] == 'test@example.com' &&
            x.namedArguments[const Symbol('password')] == 'password123') {
          return Success(mockLoginEntity);
        }
        return Failure(
          const ApiError(statusCode: 401, message: 'Invalid credentials'),
        );
      });
      loginCubit = LoginCubit(mockLoginUseCase);
    });

    tearDown(() {
      loginCubit.close();
    });

    test('initial state is LoginInitial', () {
      expect(loginCubit.state, isA<LoginInitial>());
    });

    test(
      'should emit LoginLoading then LoginSuccess on valid credentials',
      () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        // Act & Assert
        expectLater(
          loginCubit.stream,
          emitsInOrder([isA<LoginLoading>(), isA<LoginSuccess>()]),
        );

        await loginCubit.login(
          email: email,
          password: password,
          rememberMe: true,
        );
      },
    );

    test(
      'should emit LoginLoading then LoginFailure on empty credentials',
      () async {
        // Arrange
        const email = '';
        const password = '';

        // Act & Assert
        expectLater(
          loginCubit.stream,
          emitsInOrder([isA<LoginLoading>(), isA<LoginFailure>()]),
        );

        await loginCubit.login(
          email: email,
          password: password,
          rememberMe: false,
        );
      },
    );
  });
}

class MockAuthRepository extends Mock implements AuthRepository {}
