import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pnone_auth/modules/users/presentation/bloc/users_bloc.dart';

import '../../../../utils/common_app_widgets.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  final _commonWidgets = CommonWidgets();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc()..add(GetUsersDataEvent()),
      child: BlocListener<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is ErrorState) {
            _commonWidgets.showDialog(context, state.message);
          } else if (state is UsersLoadedState) {
            log(state.users.toString());
          }
          log(state.toString());
        },
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: state is LoadingState
                      ? CupertinoActivityIndicator()
                      : state is UsersLoadedState
                          ? ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Text(state.users[index]
                                          .toJson()
                                          .toString())
                                    ],
                                  ))
                          : const Text("gdfgdsj"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
