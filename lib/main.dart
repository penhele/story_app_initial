import 'package:tes_auth/service/auth_service.dart';

import '../db/auth_repository.dart';
import '../provider/auth_provider.dart';
import '../routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/url_strategy.dart';
import 'routes/route_information_parser.dart';

void main() {
  usePathUrlStrategy();
  runApp(const QuoteApp());
}

class QuoteApp extends StatefulWidget {
  const QuoteApp({super.key});

  @override
  State<QuoteApp> createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  late MyRouterDelegate myRouterDelegate;
  late MyRouteInformationParser myRouteInformationParser;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();

    authProvider = AuthProvider(authRepository, AuthService());

    myRouterDelegate = MyRouterDelegate(authRepository);

    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp.router(
        title: 'Quotes App',
        routerDelegate: myRouterDelegate,
        routeInformationParser: myRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
