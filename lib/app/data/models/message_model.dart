class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime time;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.time,
  });
}
