import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pnone_auth/modules/login/data/models/login_model.dart';
import 'package:pnone_auth/modules/login/data/datasources/firebase/firestore_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String verification_id = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) => emit(LoginInitial()));
    on<SendOtpToNumberEvent>(sentOtpForMobleNumber);
    on<SendOtpCallBackEvent>(sendOtpSuccessCallBack);
    on<ErrorStateCallbackEvent>(errorStateCallback);
    on<OneTimePasswordVerificationEvent>(oneTimePasswordVerification);
  }

  Future<void> sentOtpForMobleNumber(
      SendOtpToNumberEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LodingState());

      await auth.signOut();

      /// [verify the user's phone number and sign]
      await auth.verifyPhoneNumber(
        phoneNumber: event.number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await auth.signInWithCredential(credential);
          add(SendOtpCallBackEvent());
        },
        verificationFailed: (FirebaseAuthException e) {
          add(ErrorStateCallbackEvent(message: e.code.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          log(verificationId, name: "VERIFICATIONID");
          verification_id = verificationId;
          add(SendOtpCallBackEvent());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          add(const ErrorStateCallbackEvent(
            message: "Time out for the verification",
          ));
        },
      );
    } catch (e) {
      emit(const ErrorOccurredState(message: "Something went wrong"));
    }
  }

  Future<void> oneTimePasswordVerification(
      OneTimePasswordVerificationEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LodingState());
      // Verify the OTP using the verification ID
      final credential = PhoneAuthProvider.credential(
        verificationId: verification_id,
        smsCode: event.oneTimePasswoord,
      );

      // Sign in the user with the credential
      await auth.signInWithCredential(credential);

      // Checking user is logined
      final user = auth.currentUser;
      log(user?.uid ?? "NULL".toString(), name: "IIUUD");
      if (user != null) {
        await FirebaseDatabaseHelper().addLoginInformation(LoginModel(
            id: user.uid,
            generatedNumber: math.Random().nextInt(99999),
            userId: user.uid,
            dateTime: DateTime.now(),
            ip: '192.168.0.166',
            address: "address"));
        emit(const UserLoginSuccessState(user: "logened"));
      } else {
        emit(const ErrorOccurredState(message: "Something went wrong!"));
      }
    } on FirebaseAuthException catch (e) {
      //TODO: handle exception
      emit(ErrorOccurredState(message: e.code));
    } catch (e) {
      emit(const ErrorOccurredState(message: "Something went wrong!"));
    }
  }

  void sendOtpSuccessCallBack(
      SendOtpCallBackEvent event, Emitter<LoginState> emit) async {
    emit(SendOtpSuccessState());
  }

  void errorStateCallback(
      ErrorStateCallbackEvent event, Emitter<LoginState> emit) async {
    emit(ErrorOccurredState(message: event.message));
  }
}
