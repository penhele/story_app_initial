import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/add_story_provider.dart';
import '../provider/home_provider.dart';
import '../common/url_strategy.dart';
import '../routes/route_information_parser.dart';
import '../api/api_service.dart';
import '../db/auth_repository.dart';
import '../provider/auth_provider.dart';
import '../provider/story_detail_provider.dart';
import '../provider/story_list_provider.dart';
import '../service/auth_service.dart';

import '../routes/router_delegate.dart';

void main() {
  usePathUrlStrategy();
  runApp(const StoryApp());
}

class StoryApp extends StatefulWidget {
  const StoryApp({super.key});

  @override
  State<StoryApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<StoryApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late MyRouteInformationParser myRouteInformationParser;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final authService = AuthService();

    authProvider = AuthProvider(authRepository, authService)..loadToken();

    myRouteInformationParser = MyRouteInformationParser();

    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(
          create:
              (context) => StoryListProvider(
                ApiService(),
                Provider.of<AuthProvider>(context, listen: false),
              ),
        ),
        ChangeNotifierProvider(
          create:
              (context) => StoryDetailProvider(
                ApiService(),
                Provider.of<AuthProvider>(context, listen: false),
              ),
        ),

        // home provider
        ChangeNotifierProvider(create: (context) => HomeProvider()),

        // add story provider
        ChangeNotifierProvider(
          create: (context) => AddStoryProvider(ApiService(), AuthRepository()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Story App',
        routerDelegate: myRouterDelegate,
        routeInformationParser: myRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
