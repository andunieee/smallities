import 'package:flutter/material.dart';
import 'package:rinf/rinf.dart';
import 'package:smallities/chat/chat_view.dart';
import 'package:smallities/src/bindings/bindings.dart';

void main() {
  initializeRust(assignRustSignal);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'smallities',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatView();
  }
}
