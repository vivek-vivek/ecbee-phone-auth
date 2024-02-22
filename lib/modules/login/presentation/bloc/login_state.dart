part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LodingState extends LoginState {}

class SendOtpSuccessState extends LoginState {}

final class ErrorOccurredState extends LoginState {
  final String message;
  const ErrorOccurredState({required this.message});
  @override
  List<Object> get props => [message];
}

class UserLoginSuccessState extends LoginState {
  final dynamic user;
  const UserLoginSuccessState({required this.user});
  @override
  List<Object> get props => [user];
}
