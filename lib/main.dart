import "package:flutter/material.dart";
import "package:rinf/rinf.dart";
import "package:smallities/chat/chat_list.dart";
import "package:smallities/chat/chat_view.dart";
import "package:smallities/src/bindings/bindings.dart";

void main() {
  initializeRust(assignRustSignal);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "smallities",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _selectedChatId;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 600;
      if (isWide) {
        return Row(
          children: [
            SizedBox(
              width: 300,
              child: ChatList(
                onChatSelected: (chatId) {
                  setState(() {
                    _selectedChatId = chatId;
                  });
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _selectedChatId == null
                  ? const Center(child: Text("Select a chat"))
                  : ChatView(
                      chatId: _selectedChatId!,
                      onBack: () {},
                    ),
            ),
          ],
        );
      } else {
        if (_selectedChatId == null) {
          return ChatList(
            onChatSelected: (chatId) {
              setState(() {
                _selectedChatId = chatId;
              });
            },
          );
        } else {
          return ChatView(
            chatId: _selectedChatId!,
            onBack: () {
              setState(() {
                _selectedChatId = null;
              });
            },
          );
        }
      }
    });
  }
}
