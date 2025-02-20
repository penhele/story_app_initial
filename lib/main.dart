import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_initial/db/auth_repository.dart';
import 'package:story_app_initial/provider/auth_provider.dart';
import 'package:story_app_initial/routes/router_delegate.dart';

void main() {
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

  String? selectedStory;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();

    authProvider = AuthProvider(authRepository);

    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp(
        title: 'Stories App',
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
