import 'package:flutter/cupertino.dart';

class CommonErrorWidget extends StatelessWidget {
  final String message;
  const CommonErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
