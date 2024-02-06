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
import 'package:soiscan/app_navigation.dart';

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
            AppNavigation.router.goNamed('dashboard');
          } else if (state is AuthenticationUnautenticated) {
            AppNavigation.router.goNamed('home');
          }  else if (state is AuthenticationLoading){
            AppNavigation.router.goNamed('splashscreen');
          }
        },
        child: MaterialApp.router(
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          debugShowCheckedModeBanner: false,
          routerConfig: AppNavigation.router
        ),
      ),
    );
  }
}
