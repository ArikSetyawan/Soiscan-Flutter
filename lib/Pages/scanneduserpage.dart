import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:soiscan/Bloc/Interaction/interaction_bloc.dart';
import 'package:soiscan/Bloc/Location/location_bloc.dart';
import 'package:soiscan/theme.dart';

class ScannedUserPage extends StatefulWidget {
  final String userID;
  const ScannedUserPage({super.key, required this.userID});

  @override
  State<ScannedUserPage> createState() => _ScannedUserPageState();
}

class _ScannedUserPageState extends State<ScannedUserPage> {
  @override
  void initState() {
    context
        .read<InteractionBloc>()
        .add(GetInteractedUser(userID: widget.userID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool locationReady = false;
    Position? position;
    return BlocListener<InteractionBloc, InteractionState>(
      listener: (context, state) {
        if (state is InteractionCreated) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Interaction Created")));
          context.goNamed("dashboard");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Confirmation"),
        ),
        body: SafeArea(child: BlocBuilder<InteractionBloc, InteractionState>(
          builder: (context, state) {
            if (state is InteractionUserLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text("Confirmation",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: darkgreyColor)),
                    const SizedBox(height: 10),
                    const Text("Confirm that you meet with this person"),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: darkgreyColor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                              child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                  width: 150,
                                  height: 150)),
                          const SizedBox(height: 10),
                          Text(state.user.name,
                              style: const TextStyle(fontSize: 20)),
                          BlocBuilder<LocationBloc, LocationState>(
                            builder: (context, state) {
                              if (state is LocationLoaded) {
                                locationReady = true;
                                position = state.position;
                                return Text(state.address);
                              } else if (state is LocationLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is LocationError) {
                                return Text(state.message);
                              } else {
                                return const Text("-");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (locationReady) {
                            context.read<InteractionBloc>().add(
                                InteractWithOtherUser(
                                    nik: state.user.nik,
                                    latitude: position!.latitude,
                                    longitude: position!.longitude));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            backgroundColor: darkgreyColor),
                        child: const Text(
                          "Record",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is InteractionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is InteractionError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                    child: Column(
                  children: [
                    Image.asset("assets/images/underconstruction.jpg"),
                    Text(state.message),
                  ],
                )),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        )),
      ),
    );
  }
}
