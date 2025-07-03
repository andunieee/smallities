import 'package:flutter/material.dart';
import 'package:rinf/rinf.dart';
import 'package:smallities/src/bindings/bindings.dart';

Future<void> main() async {
  await initializeRust(assignRustSignal);
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
      home: const Home(title: 'smallities'),
    );
  }
}

class Home extends StatelessWidget {
  final String title;

  const Home({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    int currentNumber = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('current number'),
            StreamBuilder(
              stream: Box.rustSignalStream,
              builder: (context, snapshot) {
                final signalPack = snapshot.data;
                if (signalPack != null) {
                  currentNumber = signalPack.message.currentNumber;
                }
                return Text(
                  currentNumber.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Box(currentNumber: currentNumber + 1).sendSignalToRust();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
