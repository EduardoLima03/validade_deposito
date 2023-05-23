import 'package:deposito/src/models/string_inport.dart';
import 'package:flutter/material.dart';

getSplashLaptop() {
  return const Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.precision_manufacturing_rounded,
            size: 600.0,
          ),
          Text(
            'Versão\n $VERSION',
            style: TextStyle(fontSize: 40.0),
          ),
        ]),
  );
}
