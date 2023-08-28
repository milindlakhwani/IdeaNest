import 'package:flutter/material.dart';

// Error text is used anywhere stream provider is used, and since stream provider is used in lot of places.
// a separate file is made.

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
