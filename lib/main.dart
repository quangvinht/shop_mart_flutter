import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/consts/theme_data.dart';
import 'package:shop_mart/providers/theme_provider.dart';
import 'package:shop_mart/root_screen.dart';
import 'package:shop_mart/screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkTheme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Shopping',
      theme: Styles.themeData(isDarkTheme: isDarkTheme, context: context),
      home: const LoginScreen(),
    );
  }
}
