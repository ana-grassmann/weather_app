import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String info;

  const Loading({super.key, this.info = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), Text(info)],
        ),
      ),
    );
  }
}
