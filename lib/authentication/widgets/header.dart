import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(subtitle),
      ],
    );
  }
}
