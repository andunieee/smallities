import 'package:flutter/material.dart';
import 'package:smallities/chat/message_bubble.dart';
import 'package:smallities/src/bindings/bindings.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = [];
    final TextEditingController controller = TextEditingController();

    controller.addListener(() {
      final String text = controller.text.toLowerCase();
      controller.value = controller.value.copyWith(
        text: text,
        selection: TextSelection(
          baseOffset: text.length,
          extentOffset: text.length,
        ),
        composing: TextRange.empty,
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ChatMessage.rustSignalStream,
              builder: (context, snapshot) {
                final signalPack = snapshot.data;
                if (signalPack != null) {
                  messages.add(signalPack.message);
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    final message = messages[messages.length - 1 - index];
                    return MessageBubble(message: message);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Send a message...',
                    ),
                    onSubmitted: (_) {
                      MessageSent(content: controller.text).sendSignalToRust();
                      controller.text = "";
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    MessageSent(content: controller.text).sendSignalToRust();
                    controller.text = "";
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
