import 'package:deposito/src/views/splash_scree/splash_laptop.dart';
import 'package:deposito/src/views/splash_scree/splash_tablet.dart';
import 'package:flutter/material.dart';

import 'src/views/splash_scree/splash_smartphone.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 580) {
          return getSplashSmartphone();
        } else if (constraints.maxWidth > 580 && constraints.maxWidth <= 800) {
          return getSplashTable();
        } else {
          return getSplashLaptop();
        }
      }),
    );
  }
}
