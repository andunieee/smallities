import 'package:flutter/material.dart';
import 'package:smallities/src/bindings/bindings.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!message.isMe)
          CircleAvatar(
            backgroundImage: message.user.avatar != null
                ? NetworkImage(message.user.avatar!)
                : null,
            child:
                message.user.avatar == null ? Text(message.user.name[0]) : null,
          ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: message.isMe
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: !message.isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                bottomRight: message.isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment: message.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  message.content,
                  style: TextStyle(
                    color: message.isMe ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (message.isMe)
          CircleAvatar(
            backgroundImage: message.user.avatar != null
                ? NetworkImage(message.user.avatar!)
                : null,
            child:
                message.user.avatar == null ? Text(message.user.name[0]) : null,
          ),
      ],
    );
  }
}
