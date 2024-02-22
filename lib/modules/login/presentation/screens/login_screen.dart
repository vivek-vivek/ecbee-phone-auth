import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pnone_auth/modules/login/presentation/bloc/login_bloc.dart';
import 'package:pnone_auth/utils/app_colors.dart';

import '../../../../utils/common_app_widgets.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TODO: REMOVE STATIC NUMBER AFTER TESTING
  final TextEditingController numberController =
      TextEditingController(text: "+918089246277");
  final TextEditingController otpController = TextEditingController();
  final _comonWidgets = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          buildRoundContainer(context),
          buildLoginBody(),
          buildLoginTitle(context)
        ],
      ),
    );
  }

  Positioned buildLoginTitle(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * 0.15,
      left: MediaQuery.sizeOf(context).width * 0.3,
      right: MediaQuery.sizeOf(context).width * 0.3,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.3,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
                letterSpacing: 3,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 25),
          ),
        ),
      ),
    );
  }

  dynamic buildLoginBody() {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(
            //         builder: (context) => DashboardScreen(
            //               phoneNumber: numberController.text,
            //             )),
            //     (Route<dynamic> route) => false);
          } else if (state is ErrorOccurredState) {
            _comonWidgets.showDialog(context, state.message);
          }
          log("$state", name: "STATE_");
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Positioned(
              top: MediaQuery.sizeOf(context).height * 0.169,
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                height: MediaQuery.sizeOf(context).height * 7,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: MediaQuery.sizeOf(context).height * 0.15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.07,
                            child: TextFormField(
                              controller: numberController,
                              cursorColor: AppColors.white,
                              style: const TextStyle(color: AppColors.white),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: AppColors.deepPurple,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state is! LoginInitial)
                      Container(
                        margin:
                            const EdgeInsets.only(left: 25, right: 25, top: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "OTP",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.07,
                              child: TextFormField(
                                controller: otpController,
                                style: const TextStyle(color: AppColors.white),
                                cursorColor: AppColors.white,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: AppColors.deepPurple,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        final bloc = BlocProvider.of<LoginBloc>(context);
                        if (numberController.text.trim().isEmpty) {
                          _comonWidgets.showDialog(
                              context, "Enter the phone number");
                        } else if (bloc.verification_id.trim().isNotEmpty &&
                            otpController.text.trim().isEmpty) {
                          _comonWidgets.showDialog(
                              context, "Enter the one time password (OTP)");
                        } else {
                          if (bloc.verification_id.trim().isNotEmpty &&
                              otpController.text.isNotEmpty) {
                            context.read<LoginBloc>().add(
                                OneTimePasswordVerificationEvent(
                                    oneTimePasswoord: otpController.text));
                          } else {
                            context.read<LoginBloc>().add(
                                SendOtpToNumberEvent(numberController.text));
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).width * 0.14,
                          left: 25,
                          right: 25,
                        ),
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: MediaQuery.sizeOf(context).width * 0.17,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 81, 84, 84),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: state is LodingState
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white)
                              : Text(
                                  state is LoginInitial ? "Send Otp" : "Login",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Positioned buildRoundContainer(BuildContext context) {
    return Positioned(
      top: -25,
      left: MediaQuery.sizeOf(context).width * 0.65,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}
