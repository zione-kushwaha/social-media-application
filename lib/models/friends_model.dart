class FriendRequest {
  final String userName;
  final String userProfilePic;
  final int mutualFriends;
  bool isAccepted;

  FriendRequest({
    required this.userName,
    required this.userProfilePic,
    required this.mutualFriends,
    this.isAccepted = false,
  });
}

class FriendSuggestion {
  final String userName;
  final String userProfilePic;
  final int mutualFriends;

  FriendSuggestion({
    required this.userName,
    required this.userProfilePic,
    required this.mutualFriends,
  });
}
