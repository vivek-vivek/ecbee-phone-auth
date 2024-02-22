part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class LoadingState extends UsersState {}

final class ErrorState extends UsersState {
  final String message;

  const ErrorState({required this.message});
}

final class UsersLoadedState extends UsersState {
  final List<UsersModel> users;

  const UsersLoadedState({required this.users});

  @override
  List<Object> get props => [users];
}
