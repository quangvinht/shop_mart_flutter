import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_mart/widgets/title_text.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key, required this.text, this.fontSize = 30});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(
        seconds: 12,
      ),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: TitleText(
        label: text,
        fontSize: fontSize,
      ),
    );
  }
}
