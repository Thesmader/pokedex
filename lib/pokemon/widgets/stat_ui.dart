import 'package:flutter/material.dart';

class StatUI extends StatelessWidget {
  const StatUI({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: '$title ',
                style: const TextStyle(
                  color: Color(0xFF6b6b6b),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: value.toString(),
                    style: const TextStyle(
                      color: Color(0xFF161a33),
                    ),
                  )
                ]),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: value / 100)
        ],
      ),
    );
  }
}
