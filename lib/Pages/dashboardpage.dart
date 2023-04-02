import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soiscan/Bloc/Authentication/authentication_bloc.dart';
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const Text("Helloworld"),
              ElevatedButton(onPressed: () {
                context.read<AuthenticationBloc>().add(LogoutEvent());
              }, 
              child: const Text('Logout'))
            ],
          )
        ),
      ),
    );
  }
}