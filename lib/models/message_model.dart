class Message {
  final String messageId;
  final String senderId;
  final String recipientId;
  final DateTime timestamp;
  final String text;

  Message({
    required this.messageId,
    required this.senderId,
    required this.recipientId,
    required this.timestamp,
    required this.text,
  });
}