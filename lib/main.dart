import 'package:provider/provider.dart';
import 'package:tes_auth/api/api_service.dart';
import 'package:tes_auth/db/auth_repository.dart';
import 'package:tes_auth/provider/auth_provider.dart';
import 'package:tes_auth/service/auth_service.dart';

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
      providers: [ChangeNotifierProvider(create: (context) => authProvider)],
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
