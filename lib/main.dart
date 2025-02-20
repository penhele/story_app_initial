import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_initial/common/url_strategy_web.dart';
import 'package:story_app_initial/db/auth_repository.dart';
import 'package:story_app_initial/provider/auth_provider.dart';
import 'package:story_app_initial/routes/route_information_parser.dart';
import 'package:story_app_initial/routes/router_delegate.dart';

void main() {
  usePathUrlStrategy();
  runApp(const StoriesApp());
}

class StoriesApp extends StatefulWidget {
  const StoriesApp({super.key});

  @override
  State<StoriesApp> createState() => _StoriesAppState();
}

class _StoriesAppState extends State<StoriesApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late MyRouteInformationParser myRouteInformationParser;

  String? selectedStory;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();

    authProvider = AuthProvider(authRepository);

    myRouterDelegate = MyRouterDelegate(authRepository);

    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp.router(
        title: 'Stories App',
        routerDelegate: myRouterDelegate,
        routeInformationParser: myRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
