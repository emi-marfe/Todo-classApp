import 'package:flutter/material.dart';
import 'package:mytodo/screens/signupscreen.dart';

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: signupscreen(),
    );
  }
}
