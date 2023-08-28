import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicator({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
