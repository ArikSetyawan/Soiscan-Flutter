import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soiscan/Bloc/Authentication/authentication_bloc.dart';
import 'package:soiscan/Bloc/Login/login_bloc.dart';
import 'package:soiscan/Pages/dashboardpage.dart';
import 'package:soiscan/Pages/homepage.dart';
import 'package:go_router/go_router.dart';
import 'package:soiscan/Pages/loginpage.dart';
import 'package:soiscan/Pages/searchpage.dart';
import 'package:soiscan/Pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'login',
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
      ],
    ),
    GoRoute(
      name: 'dashboard',
      path: '/dashbord',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      builder: (BuildContext context, GoRouterState state) {
        return const SearchPage();
      },
    ),
    GoRoute(
      name: 'splashscreen',
      path: '/splash',
      builder: (BuildContext context, GoRouterState state){
        return const SplashPage();
      },
    ),
  ],
  initialLocation: "/splash",
  debugLogDiagnostics: true,
  routerNeglect: true
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc()..add(ValidationEvent()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        )
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAutenticated) {
            _router.goNamed('dashboard');
          } else if (state is AuthenticationUnautenticated) {
            _router.goNamed('home');
          }  else if (state is AuthenticationLoading){
            _router.goNamed('splashscreen');
          }
        },
        child: MaterialApp.router(
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          debugShowCheckedModeBanner: false,
          routerConfig: _router
        ),
      ),
    );
  }
}
