import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/datasources/firebase/firestore_helper.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<GetCurrentUserInformationEvent>(getCurrentUserInformation);
  }

  Future<void> getCurrentUserInformation(
    GetCurrentUserInformationEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(LoadingState());
      final user = await FirebaseDatabaseHelper().getCurrentUserInformation();
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
