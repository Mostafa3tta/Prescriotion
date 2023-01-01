part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class RegisterErrorState extends AuthState {
  final String onEror;

  RegisterErrorState(this.onEror);
}
class CreateUserSuccessState extends AuthState {}
class CreateUserErrorState extends AuthState {
  final String onEror;

  CreateUserErrorState(this.onEror);
}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final String uID;
  final String role;
  final String email;
  final String name;
  LoginSuccessState({required this.email, required this.name, required this.uID,required this.role});
}
class LoginErrorState extends AuthState {
  final String onError;
  LoginErrorState(this.onError);
}
