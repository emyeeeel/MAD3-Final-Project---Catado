

class UserModel{
  final String userId;
  final String email;
  final String username;
  final String bio;
  final String displayName;
  final String profileImageUrl;
  final List<String> following;
  final List<String> followers;
  final List<String> posts;

  UserModel({
    required this.userId,
    required this.email, 
    required this.username, 
    required this.bio, 
    required this.displayName, 
    required this.profileImageUrl, 
    required this.following, 
    required this.followers, 
    required this.posts});
}