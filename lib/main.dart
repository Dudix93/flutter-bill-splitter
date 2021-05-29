import 'package:flutter/material.dart';

void main() {
  runApp(HelloWorld());
}

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello World",
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.red, fontSize: 24)),
    );
  }
}
