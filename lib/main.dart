import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soiscan/Bloc/Authentication/authentication_bloc.dart';
import 'package:soiscan/Bloc/History/history_bloc.dart';
import 'package:soiscan/Bloc/Homepage/homepage_bloc.dart';
import 'package:soiscan/Bloc/Interaction/interaction_bloc.dart';
import 'package:soiscan/Bloc/Location/location_bloc.dart';
import 'package:soiscan/Bloc/Login/login_bloc.dart';
import 'package:soiscan/Bloc/Registration/registration_bloc.dart';
import 'package:soiscan/Models/user.dart';
import 'package:soiscan/Pages/accountpage.dart';
import 'package:soiscan/Pages/dashboardpage.dart';
import 'package:soiscan/Pages/historypage.dart';
import 'package:soiscan/Pages/homepage.dart';
import 'package:go_router/go_router.dart';
import 'package:soiscan/Pages/loginpage.dart';
import 'package:soiscan/Pages/scanneduserpage.dart';
import 'package:soiscan/Pages/scanpage.dart';
import 'package:soiscan/Pages/searchpage.dart';
import 'package:soiscan/Pages/signup.dart';
import 'package:soiscan/Pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Open Isar
  final dir = await getApplicationDocumentsDirectory();
  await Isar.open(
    [UserSchema],
    inspector: true,
    directory: dir.path
  );

  // Load .env
  await dotenv.load(fileName: ".env");

  
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
            return LoginPage();
          },
        ),
        GoRoute(
          name: 'signup',
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return SignupPage();
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
      name: 'scan',
      path: '/scan',
      builder: (context, state) {
        return const ScanPage();
      },
      routes: [
        GoRoute(
          name: 'scannedUser',
          path: 'user',
          builder: (context, state) {
            return ScannedUserPage(
              userID: state.uri.queryParameters['UserID']!,
            );
          },
        )
      ]
    ),
    GoRoute(
      name: 'history',
      path: '/history',
      builder: (context, state) {
        return const HistoryPage();
      },
    ),
    GoRoute(
      name: 'account',
      path: '/account',
      builder: (context, state) {
        return const AccountPage();
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
        ),
        BlocProvider(
          create: (context) => HomepageBloc(),
        ),
        BlocProvider(
          create: (context) => InteractionBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(),
        )
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAutenticated) {
            context.read<LocationBloc>().add(GetDeviceLocation());
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
