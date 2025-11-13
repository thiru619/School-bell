import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/responsive_helper.dart';
import '../controllers/chat_controller.dart';
import '../widgets/message_bubble.dart';

class ChatView extends StatelessWidget {
  final ChatController controller = Get.find<ChatController>();
  final TextEditingController inputController = TextEditingController();

  ChatView({Key? key}) : super(key: key);

  final sampleUsers = [
    ChatUser(id: 'user_2', name: 'Teacher A'),
    ChatUser(id: 'user_3', name: 'Teacher B'),
    ChatUser(id: 'user_4', name: 'Student C'),
  ];

  @override
  Widget build(BuildContext context) {
    final bool tablet = ResponsiveHelper.isTablet(context);

    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: tablet ? buildTabletLayout(context) : buildMobileLayout(context),
    );
  }

  Widget buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 320,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Chats',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sampleUsers.length,
                  itemBuilder: (_, i) {
                    final u = sampleUsers[i];
                    return ListTile(
                      title: Text(u.name),
                      selected: controller.selectedChatUser.value?.id == u.id,
                      onTap: () => controller.selectChatUser(u),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final messages = controller.messagesFor(
              controller.selectedChatUser.value ?? sampleUsers[0],
            );
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: false,
                    padding: EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (_, i) => MessageBubble(
                      message: messages[i],
                      isMine: messages[i].senderId == controller.currentUserId,
                    ),
                  ),
                ),
                buildInputArea(),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            final messages = controller.messagesFor(
              controller.selectedChatUser.value ?? sampleUsers[0],
            );
            return ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (_, i) => MessageBubble(
                message: messages[i],
                isMine: messages[i].senderId == controller.currentUserId,
              ),
            );
          }),
        ),
        buildInputArea(),
      ],
    );
  }

  Widget buildInputArea() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                onSubmitted: (v) {
                  controller.sendMessage(v);
                  inputController.clear();
                },
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                controller.sendMessage(inputController.text);
                inputController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
