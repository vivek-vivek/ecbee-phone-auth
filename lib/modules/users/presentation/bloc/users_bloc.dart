import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pnone_auth/modules/users/data/datasources/firebase/firestore_helper.dart';

import '../../data/models/users_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersEvent>((event, emit) {});
    on<GetUsersDataEvent>(getUserList);
  }

  final _firebaseHelper = FirebaseDatabaseHelper();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getUserList(
      GetUsersDataEvent event, Emitter<UsersState> emit) async {
    try {
      emit(LoadingState());
      // final doc =
      //     _firestore.collection('login_info').doc(); // Create a new Document

      // await doc.set(UsersModel(
      //         id: doc.id,
      //         // generatedNumber: 7656789,
      //         userId: "",
      //         dateTime: DateTime.now(),
      //         ip: "098765",
      //         address: "00000")
      //     .toJson());

      final users = await _firebaseHelper.getLastLogin();
      log(users.toString(), name: "USERS");
      if (users != null) {
        emit(UsersLoadedState(users: users));
      } else {
        emit(const ErrorState(message: "Users not found!"));
      }
    } catch (e) {
      emit(const ErrorState(message: "Something went wrong!"));
    }
  }
}
