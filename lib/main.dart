import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/firebase_options.dart';
import 'package:shop_mart/providers/order_provider.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/providers/theme_provider.dart';
import 'package:shop_mart/providers/user_provider.dart';
import 'package:shop_mart/root_screen.dart';
import 'package:shop_mart/screens/inner_screen/product_details.dart';
import 'package:shop_mart/screens/inner_screen/viewed_recently.dart';
import 'package:shop_mart/services/notification_service.dart';

import 'consts/theme_data.dart';
import 'providers/cart_provider.dart';
import 'providers/viewed_recently_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/inner_screen/orders/orders_screen.dart';
import 'screens/inner_screen/wishlist.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(snapshot.error.toString()),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductsProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProdProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return OrderProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Shopping',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const LoginScreen(),
                //home: const RootScreen(),
                routes: {
                  RootScreen.routeName: (context) => const RootScreen(),
                  ProductDetailsScreen.routName: (context) =>
                      const ProductDetailsScreen(),
                  WishlistScreen.routName: (context) => const WishlistScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routName: (context) => const RegisterScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                },
              );
            }),
          );
        });
  }
}
