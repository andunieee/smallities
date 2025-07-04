import "package:flutter/material.dart";
import "package:smallities/chat/chat_input_field.dart";
import "package:smallities/chat/message_bubble.dart";
import "package:smallities/src/bindings/bindings.dart";

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = [];

    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
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
          const ChatUITextField(),
        ],
      ),
    );
  }
}
