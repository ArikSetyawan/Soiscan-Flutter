import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:soiscan/Pages/accountpage.dart';
import 'package:soiscan/Pages/dashboardpage.dart';
import 'package:soiscan/Pages/historypage.dart';
import 'package:soiscan/Pages/homepage.dart';
import 'package:soiscan/Pages/loginpage.dart';
import 'package:soiscan/Pages/mainwrapper.dart';
import 'package:soiscan/Pages/scanneduserpage.dart';
import 'package:soiscan/Pages/scanpage.dart';
import 'package:soiscan/Pages/searchpage.dart';
import 'package:soiscan/Pages/signup.dart';
import 'package:soiscan/Pages/splash_page.dart';

class AppNavigation {
  AppNavigation._();

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigationSearch = GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
  static final _shellNavigatorHistory = GlobalKey<NavigatorState>(debugLabel: 'shellHistory');
  static final _shellNavigationUser = GlobalKey<NavigatorState>(debugLabel: 'shellUser');

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routerNeglect: true,
    routes: [
      GoRoute(
        name: 'splashscreen',
        path: '/splash',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: 'home',
        path: '/',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'login',
            path: 'login',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return LoginPage();
            },
          ),
          GoRoute(
            name: 'signup',
            path: 'signup',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return SignupPage();
            },
          ),
        ],
      ),
      GoRoute(
        name: 'scan',
        path: '/scan',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ScanPage(),
        routes: [
          GoRoute(
            name: 'scannedUser',
            path: 'user',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => ScannedUserPage(userID: state.uri.queryParameters['UserID']!)
          )
        ]
      ),
      // MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainWrapper(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          /// Brach Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                name: 'dashboard',
                path: '/dashbord',
                builder: (context, state) => DashboardPage(key: state.pageKey,),
              ),              
            ]
          ),

          /// Brach Search
          StatefulShellBranch(
            navigatorKey: _shellNavigationSearch,
            routes: <RouteBase>[
              GoRoute(
                name: 'search',
                path: '/search',
                builder: (BuildContext context, GoRouterState state) => const SearchPage()
              ),              
            ]
          ),

          /// Branch History
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHistory,
            routes: <RouteBase>[
              GoRoute(
                path: "/history",
                name: "history",
                builder: (context, state) => const HistoryPage(),
              )
            ]
          ),

          /// Brach Account
          StatefulShellBranch(
            navigatorKey: _shellNavigationUser,
            routes: <RouteBase>[
              GoRoute(
                name: 'account',
                path: '/account',
                builder: (context, state) => const AccountPage(),
              ),
            ]
          ),
        ]
      ),
    ]
  );
}