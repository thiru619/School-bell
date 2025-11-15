import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final currentUserId = 'user_1';
  final currentUserName = 'You';

  var messages = <Message>[].obs;
  var selectedChatUser = Rxn<ChatUser>();

  ChatController() {
    // Seed with sample conversations
    messages.addAll([
      Message(
        id: Uuid().v4(),
        senderId: 'user_2',
        senderName: 'Teacher A',
        text: 'Hello class!',
        time: DateTime.now().subtract(Duration(minutes: 5)),
      ),
      Message(
        id: Uuid().v4(),
        senderId: 'user_1',
        senderName: 'You',
        text: 'Hi Teacher!',
        time: DateTime.now().subtract(Duration(minutes: 4)),
      ),
      Message(
        id: Uuid().v4(),
        senderId: 'user_2',
        senderName: 'Teacher A',
        text: 'Please check today\'s homework.',
        time: DateTime.now().subtract(Duration(minutes: 2)),
      ),
    ]);

    // Default chat user
    selectedChatUser.value = ChatUser(id: 'user_2', name: 'Teacher A');
  }

  List<Message> messagesFor(ChatUser user) {
    // In local demo: return all messages for simplicity
    return messages;
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final msg = Message(
      id: Uuid().v4(),
      senderId: currentUserId,
      senderName: currentUserName,
      text: trimmed,
      time: DateTime.now(),
    );
    messages.add(msg);
  }

  void selectChatUser(ChatUser user) {
    selectedChatUser.value = user;
  }
}

class ChatUser {
  final String id;
  final String name;
  ChatUser({required this.id, required this.name});
}
