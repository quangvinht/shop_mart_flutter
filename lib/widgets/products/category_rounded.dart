import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_mart/screens/search_screen.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';

class CategoryRounded extends StatelessWidget {
  const CategoryRounded({super.key, required this.image, required this.name});

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => SearchScreen(
              category: name,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              image,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SubtitleText(
            title: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
