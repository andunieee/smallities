import "package:flutter/material.dart";

class ChatList extends StatelessWidget {
  final Function(String) onChatSelected;

  const ChatList({super.key, required this.onChatSelected});

  @override
  Widget build(BuildContext context) {
    // Dummy data for chat list
    final chatList = [
      {"id": "1", "name": "Alice", "lastMessage": "Hey, how are you?"},
      {"id": "2", "name": "Bob", "lastMessage": "See you tomorrow!"},
      {"id": "3", "name": "Charlie", "lastMessage": "Sounds good."},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(chat["name"]![0]),
            ),
            title: Text(chat["name"]!),
            subtitle: Text(chat["lastMessage"]!),
            onTap: () {
              onChatSelected(chat["id"]!);
            },
          );
        },
      ),
    );
  }
}
