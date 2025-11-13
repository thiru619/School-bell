import 'package:flutter/material.dart';
import '../../../data/models/message_model.dart';
import '../../../widgets/custom_text.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMine;
  const MessageBubble({required this.message, required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMine ? Theme.of(context).primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMine)
              CustomText(
                text: message.senderName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            SizedBox(height: 4),
            CustomText(
              text: message.text,
              style: TextStyle(color: isMine ? Colors.white : Colors.black87),
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomText(
                text: _formatTime(message.time),
                style: TextStyle(
                  fontSize: 10,
                  color: isMine ? Colors.white70 : Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '\$h:\$m';
  }
}
