

import 'comment_model.dart';

class PostModel {
  final String postId;
  final String imageUrl;
  final String caption;
  final DateTime timestamp;
  final List<String> likes;
  final List<CommentModel> comments;

  PostModel({
    required this.postId,
    required this.imageUrl,
    required this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });
}