# Login API Implementation

This implementation provides a complete login API integration following Clean Architecture principles and SOLID design patterns.

## Architecture Overview

The implementation follows Clean Architecture with three layers:

### 1. Domain Layer (`domain/`)
- **Entities**: Pure business objects (`LoginEntity`)
- **Repositories**: Abstract contracts (`AuthRepository`)  
- **Use Cases**: Business logic (`LoginUseCase`)

### 2. Data Layer (`data/`)
- **Models**: Data transfer objects with JSON serialization (`LoginRequest`, `LoginResponse`)
- **Data Sources**: API service using Retrofit (`AuthApiService`)
- **Repository Implementation**: Concrete implementation (`AuthRepositoryImpl`)

### 3. Presentation Layer (`presentation/`)
- **Cubit**: State management (`LoginCubit`)
- **States**: UI states (`LoginState`)
- **Views**: UI components (`LoginView`)

## Features

✅ **Retrofit Integration**: Type-safe HTTP client with automatic JSON serialization
✅ **Comprehensive Error Handling**: Structured error responses with field-level validation errors
✅ **Clean Architecture**: Separation of concerns with dependency inversion
✅ **State Management**: BLoC pattern with Cubit
✅ **Dependency Injection**: GetIt for dependency management
✅ **JSON Serialization**: Automatic JSON parsing with json_serializable
✅ **Network Configuration**: Dio interceptors and timeout configuration

## Error Handling

The implementation handles various error scenarios:

### Network Errors
- Connection timeout
- No internet connection
- Certificate errors
- Request cancellation

### Server Errors
- HTTP status codes (400, 401, 500, etc.)
- Field-level validation errors
- Custom error messages

### Error Response Structure
```dart
{
  "statusCode": 400,
  "message": "One or more errors occurred!",
  "errors": {
    "email": ["Email is not valid."],
    "password": [
      "Password must contain at least one uppercase letter.",
      "Password must contain at least one digit.",
      "Password must contain at least one special character."
    ]
  }
}
```

## Usage Example

### 1. Providing the LoginCubit

```dart
// In your widget tree
BlocProvider<LoginCubit>(
  create: (context) => locator<LoginCubit>(),
  child: LoginView(),
)
```

### 2. Using the LoginCubit

```dart
// Trigger login
context.read<LoginCubit>().login(
  email: 'user@example.com',
  password: 'password123',
  rememberMe: true,
);

// Listen to states
BlocBuilder<LoginCubit, LoginState>(
  builder: (context, state) {
    if (state is LoginLoading) {
      return CircularProgressIndicator();
    } else if (state is LoginSuccess) {
      // Handle success - navigate to home
      return Text('Welcome! Token: ${state.loginEntity.accessToken}');
    } else if (state is LoginFailure) {
      // Handle error - show message
      return Text('Error: ${state.message}');
    }
    return LoginForm();
  },
)
```

### 3. API Response Handling

```dart
// Success Response
LoginEntity(
  accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  expiresAtUtc: "2025-10-08T03:08:47.982Z",
  refreshToken: "refresh_token_here"
)

// Error Response  
ServerFailure(
  message: "One or more errors occurred!",
  statusCode: 400,
  errors: {
    "email": ["Email is not valid."],
    "password": ["Password must contain at least one uppercase letter."]
  }
)
```

## API Configuration

The implementation uses the following API configuration:

```dart
class ApiConstants {
  static const String baseUrl = 'https://accessories-eshop.runasp.net/api/';
  static const String loginEndpoint = 'auth/login';
  static const String registerEndpoint = 'auth/register';
}
```

## Dependencies

```yaml
dependencies:
  dio: ^5.9.0              # HTTP client
  retrofit: ^4.7.3         # Type-safe HTTP client
  json_annotation: ^4.9.0  # JSON serialization annotations
  dartz: ^0.10.1           # Functional programming (Either)
  flutter_bloc: ^9.1.1     # State management
  get_it: ^8.2.0           # Dependency injection

dev_dependencies:
  retrofit_generator: ^10.0.6    # Code generation for Retrofit
  json_serializable: ^6.11.1    # Code generation for JSON
  build_runner: ^2.4.13         # Code generation runner
```

## Code Generation

To generate the necessary files after making changes to models or API services:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Testing

The implementation includes unit tests with mocking:

```dart
// Mock the use case for testing
class MockLoginUseCase extends Mock implements LoginUseCase {}

// Test the cubit
final mockUseCase = MockLoginUseCase();
final cubit = LoginCubit(mockUseCase);

// Mock successful login
when(() => mockUseCase(email: any(named: 'email'), password: any(named: 'password')))
    .thenAnswer((_) async => Right(mockLoginEntity));
```

## File Structure

```
lib/
├── core/
│   └── networking/
│       ├── api_constants.dart       # API endpoints
│       ├── api_error.dart          # Error model
│       ├── api_error_handler.dart  # Error handling logic
│       └── dio_factory.dart        # Dio configuration
├── features/
│   └── auth/
│       ├── data/
│       │   ├── data_sources/
│       │   │   └── auth_api_service.dart    # Retrofit API service
│       │   ├── models/
│       │   │   ├── login_request.dart       # Request model
│       │   │   └── login_response.dart      # Response model
│       │   └── repos/
│       │       └── auth_repository_impl.dart # Repository implementation
│       ├── domain/
│       │   ├── entities/
│       │   │   └── login_entity.dart        # Domain entity
│       │   ├── repos/
│       │   │   └── auth_repository.dart     # Repository interface
│       │   └── use_cases/
│       │       └── login_use_case.dart      # Business logic
│       └── presentation/
│           ├── logic/
│           │   ├── login_cubit.dart         # State management
│           │   └── login_state.dart         # UI states
│           └── views/
│               └── login_view.dart          # UI component
```

This implementation provides a robust, maintainable, and scalable solution for handling authentication in your Flutter application.