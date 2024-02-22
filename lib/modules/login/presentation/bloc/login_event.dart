part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class SendOtpToNumberEvent extends LoginEvent {
  const SendOtpToNumberEvent(this.number);

  final String number;
  @override
  List<Object> get props => [number];
}

final class SendOtpCallBackEvent extends LoginEvent {}

final class ErrorStateCallbackEvent extends LoginEvent {
  final String message;

  const ErrorStateCallbackEvent({required this.message});
  @override
  List<Object> get props => [message];
}

final class OneTimePasswordVerificationEvent extends LoginEvent {
  final String oneTimePasswoord;
  const OneTimePasswordVerificationEvent({required this.oneTimePasswoord});
  @override
  List<Object> get props => [oneTimePasswoord];
}
