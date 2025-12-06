import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'routes.dart';
import '../core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maha Vistaar AI',
        theme: AppTheme.lightTheme,
        //initialRoute: Routes.splash,
        initialRoute: Routes.login,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
