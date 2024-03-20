import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_mart/providers/theme_provider.dart';

class GoogleBtn extends ConsumerWidget {
  const GoogleBtn({super.key, required this.onTabGgBtn});

  final void Function() onTabGgBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkTheme = ref.watch(themeProvider);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        //backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onTabGgBtn,
      icon: const Icon(Ionicons.logo_google, color: Colors.red),
      label: isDarkTheme
          ? const Text(
              'Signin with Google',
            )
          : const Text(
              'Signin with Google',
              style: TextStyle(color: Colors.black),
            ),
    );
  }
}
