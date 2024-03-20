import 'package:flutter/material.dart';

import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      required this.btnText});

  final String imagePath, title, subTitle, btnText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.25,
          ),
          const SizedBox(height: 20),
          const TitleText(
            label: 'Oh no',
            fontSize: 40,
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          SubtitleText(
            title: title,
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SubtitleText(
              title: subTitle,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            onPressed: () {},
            child: Text(btnText),
          ),
        ],
      ),
    );
  }
}
