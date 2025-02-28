import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../db/auth_repository.dart';
import '../provider/auth_provider.dart';
import '../provider/story_detail_provider.dart';
import '../provider/story_list_provider.dart';
import '../service/auth_service.dart';

import '../routes/router_delegate.dart';
import 'package:flutter/material.dart';

void main() {
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

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final authService = AuthService();
    final apiService = ApiService();

    authProvider = AuthProvider(authRepository, authService, apiService)
      ..loadToken();

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
      ],
      child: MaterialApp(
        title: 'Story App',
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
