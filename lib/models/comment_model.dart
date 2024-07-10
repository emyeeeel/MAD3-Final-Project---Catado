
class CommentModel {
  final String commentId;
  final String userId;
  final String username;
  final String text;
  final DateTime timestamp;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.username,
    required this.text,
    required this.timestamp,
  });
}