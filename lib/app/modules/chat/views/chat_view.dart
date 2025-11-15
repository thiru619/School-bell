import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/responsive_helper.dart';
import '../../../widgets/custom_textfield.dart';
import '../controllers/chat_controller.dart';
import '../widgets/message_bubble.dart';

class ChatView extends StatelessWidget {
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
      appBar: AppBar(
        leading: Icon(Icons.person_pin),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Get.toNamed('/menu'),
              child: Icon(Icons.auto_awesome_mosaic_rounded),
            ),
          ),
        ],
      ),
      body: GetBuilder<ChatController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: tablet
                ? buildTabletLayout(context, controller)
                : buildMobileLayout(context, controller),
          ),
        ),
      ),
    );
  }

  Widget buildTabletLayout(BuildContext context, controller) {
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
                buildInputArea(controller),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget buildMobileLayout(BuildContext context, controller) {
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
        buildInputArea(controller),
      ],
    );
  }

  Widget buildInputArea(controller) {
    return Row(
      children: [
        Expanded(
          child: chatInputField(
            controller: controller.inputController,
            onSend: () {
              controller.sendMessage(controller.inputController.text);
              controller.inputController.clear();
            },
            onMic: () {},
            onAttachment: () {},
          ),
        ),
      ],
    );
  }
}
