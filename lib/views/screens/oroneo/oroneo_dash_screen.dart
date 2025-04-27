import 'package:flutter/material.dart';

class OroneoDashScreen extends StatelessWidget {
  const OroneoDashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dashboard Oroneo',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}