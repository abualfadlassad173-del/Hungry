sealed class AuthState {}

class AuthInitial extends AuthState {}

// Login
class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

// Signup
class SignupLoading extends AuthState {}
class SignupSuccess extends AuthState {}
class SignupError extends AuthState {
  final String message;
  SignupError(this.message);
}

// Profile
class GetProfileLoading extends AuthState {}
class GetProfileSuccess extends AuthState {}
class GetProfileError extends AuthState {
  final String message;
  GetProfileError(this.message);
}

// Update Profile
class UpdateProfileLoading extends AuthState {}
class UpdateProfileSuccess extends AuthState {}
class UpdateProfileError extends AuthState {
  final String message;
  UpdateProfileError(this.message);
}

// pick image
class PickImageLoading extends AuthState {}
class PickImageSuccess extends AuthState {}

// auto login
class AutoLoginLoading extends AuthState {}

class AutoLoginSuccess extends AuthState {}

class AutoLoginError extends AuthState {
  final String message;
  AutoLoginError(this.message);
}