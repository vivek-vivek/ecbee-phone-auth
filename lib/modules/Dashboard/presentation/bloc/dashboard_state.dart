part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class LoadingState extends DashboardState {}

class ErrorState extends DashboardState {
  final String message;

  const ErrorState({required this.message});
}
