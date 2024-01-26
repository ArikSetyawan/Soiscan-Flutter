import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/underconstruction.jpg"),
              const Text("This Feature is unavailable.")
            ],
          ),
        ),
      ),
    );
  }
}