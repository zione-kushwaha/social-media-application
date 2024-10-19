class Post {
  final String userName;
  final String userProfilePic;
  final String postTime;
  final String postContent;
  final String postImage;
  int likes;
  int comments;
  int shares;

  Post({
    required this.userName,
    required this.userProfilePic,
    required this.postTime,
    required this.postContent,
    required this.postImage,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });
}
