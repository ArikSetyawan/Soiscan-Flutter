import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:soiscan/Bloc/Homepage/homepage_bloc.dart';
import 'package:soiscan/Bloc/Location/location_bloc.dart';
import 'package:soiscan/theme.dart';
import 'package:soiscan/Bloc/Authentication/authentication_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<HomepageBloc>().add(LoadHomepage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 460,
                  color: darkgreyColor,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 75, right: 30, left: 30, bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                  width: 150,
                                  height: 150),
                              SizedBox(
                                width: 100,
                                height: 45,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        side: const BorderSide(
                                            width: 2, color: Colors.white),
                                        backgroundColor: darkgreyColor),
                                    onPressed: () {
                                      context
                                          .read<AuthenticationBloc>()
                                          .add(LogoutEvent());
                                    },
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          BlocBuilder<HomepageBloc, HomepageState>(
                            builder: (context, state) {
                              if (state is HomepageLoaded) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Hi, ${state.user.name.split(" ").first}",
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              } else if (state is HomepageLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                          BlocBuilder<LocationBloc, LocationState>(
                            builder: (context, state) {
                              if (state is LocationLoaded) {
                                return Text(state.address,style: const TextStyle(color: Colors.white));
                              } else if (state is LocationLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 350,
                        width: screenSize.width / 1.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  blurRadius: 7,
                                  offset: const Offset(0, 3))
                            ],
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Your QR Code",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Show the QR code below to the person you meet with",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: BlocBuilder<HomepageBloc, HomepageState>(
                                builder: (context, state) {
                                  if (state is HomepageLoaded) {
                                    return QrImageView(
                                      data: state.user.userId,
                                      size: 200,
                                    );
                                  } else if (state is HomepageLoading) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else {
                                    return QrImageView(
                                      data: "Not Found",
                                      size: 200,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        )),
                    const SizedBox(height: 20)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
