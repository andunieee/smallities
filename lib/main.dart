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
      home: const MyHomePage(title: 'smallities'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            ElevatedButton(
              onPressed: () async {
                MyPreciousData(
                  inputNumbers: [3, 4, 5],
                  inputString: 'Zero-cost abstraction',
                ).sendSignalToRust(); // GENERATED
              },
              child: const Text('Send a Signal from Dart to Rust'),
            ),
            StreamBuilder(
              stream: MyAmazingNumber.rustSignalStream, // GENERATED
              builder: (context, snapshot) {
                final signalPack = snapshot.data;
                if (signalPack == null) {
                  return const Text('Nothing received yet');
                }
                final myAmazingNumber = signalPack.message;
                final currentNumber = myAmazingNumber.currentNumber;
                return Text(currentNumber.toString());
              },
            ),
            Text('1', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
