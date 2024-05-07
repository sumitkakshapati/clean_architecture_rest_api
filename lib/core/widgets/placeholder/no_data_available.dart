import 'package:flutter/material.dart';

class NoDataAvailable extends StatelessWidget {
  final String message;
  final String image;

  const NoDataAvailable({
    super.key,
    required this.message,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 180,
            ),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
