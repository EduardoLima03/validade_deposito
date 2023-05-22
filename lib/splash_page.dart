import 'package:flutter/material.dart';

import 'src/views/splash_scree/splash_smartphone.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 580) {
          return getSplashSmartphone();
        } else if (constraints.maxWidth > 580 && constraints.maxWidth <= 800) {
          return Container();
        } else {
          return Container();
        }
      }),
    );
  }
}
