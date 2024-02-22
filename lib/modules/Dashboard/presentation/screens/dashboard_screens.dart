import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../../../login/presentation/screens/login_screen.dart';
import '../bloc/dashboard_bloc.dart';
/*

Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
                (Route<dynamic> route) => false);
*/

class DashboardScreen extends StatefulWidget {
  final String phone;
  const DashboardScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          buildRoundContainer(context),
          buildDashboardBody(context),
          appBar(context),
          buildDashboardTitle(context)
        ],
      ),
    );
  }

  Positioned appBar(BuildContext context) {
    return Positioned(
        top: MediaQuery.sizeOf(context).height * 0.05,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Text(""),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Positioned buildDashboardTitle(BuildContext context) {
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
            "PLUGIN",
            style: TextStyle(
                letterSpacing: 3,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 25),
          ),
        ),
      ),
    );
  }

  Positioned buildDashboardBody(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * 0.169,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: MediaQuery.sizeOf(context).height * 7,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: QrImageView(
                data: "viivek",
                version: QrVersions.auto,
                size: MediaQuery.sizeOf(context).width * 0.4,
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                const Text(
                  "Genrated number",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "8888",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            DashboardTextData(context),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildSaveButton() {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).width * 0.05,
              ),
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: MediaQuery.sizeOf(context).width * 0.17,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 81, 84, 84),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: state is LoadingState
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : const Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container DashboardTextData(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).width * 0.2,
      ),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).width * 0.14,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8)),
      child: const Center(
        child: Text(
          "last Dashboarded in todays agoe",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
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
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}
