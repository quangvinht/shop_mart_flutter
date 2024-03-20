import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onTabTitle});
  final String title;
  final String imagePath;
  final void Function() onTabTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTabTitle,
      title: Text(title),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
