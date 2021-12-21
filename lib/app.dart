import 'package:flutter/material.dart';

import 'package:flutter_markdown_demo_app/screens/markdown_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MarkdownScreen());
  }
}
