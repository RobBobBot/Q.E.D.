import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitThreeBounce(
              color: Colors.grey,
            ),
            Text(
              'Loading...',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
