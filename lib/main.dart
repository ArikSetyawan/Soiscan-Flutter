import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soiscan/Pages/dashboardpage.dart';
import 'package:soiscan/Pages/homepage.dart';
import 'package:go_router/go_router.dart';
import 'package:soiscan/Pages/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          name: "home",
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: "login",
              name: "login",
              builder: (context, state) => const LoginPage(),
            )
          ]
        ),
        GoRoute(
          path: "/dashboard",
          name: "dashboard",
          builder: (context, state) => const DashboardPage(),
        )
      ],initialLocation: "/dashboard", routerNeglect: true, debugLogDiagnostics: true
    );
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily
      ),
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
