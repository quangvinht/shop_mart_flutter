import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/consts/theme_data.dart';
import 'package:shop_mart/firebase_options.dart';
import 'package:shop_mart/providers/theme_provider.dart';
import 'package:shop_mart/root_screen.dart';
import 'package:shop_mart/screens/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// // Ideal time to initialize
//   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
