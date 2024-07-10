import '../enum/notif_enum.dart';
import 'user_model.dart';

class NotificationModel {
  final String notificationId;
  final NotificationType type;
  final UserModel fromUser;
  final UserModel toUser;
  final String? postId;
  final bool read;
  final DateTime timestamp;

  NotificationModel({
    required this.notificationId,
    required this.type,
    required this.fromUser,
    required this.toUser,
    this.postId,
    required this.read,
    required this.timestamp,
  });
}