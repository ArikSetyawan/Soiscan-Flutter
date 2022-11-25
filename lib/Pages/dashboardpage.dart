import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
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
          child: Text("Helloworld")
        ),
      ),
    );
  }
}