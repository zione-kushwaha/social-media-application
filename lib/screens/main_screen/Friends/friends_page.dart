import 'package:flutter/material.dart';

import '../../../models/friends_model.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  _AddFriendsPageState createState() => _AddFriendsPageState();
}

class _AddFriendsPageState extends State<AddFriendsPage>
    with AutomaticKeepAliveClientMixin {
  final PageStorageBucket _bucket = PageStorageBucket();

  final List<FriendRequest> friendRequests = [
    FriendRequest(
      userName: 'Jane Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 5,
    ),
    FriendRequest(
      userName: 'John Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 2,
    ),
    FriendRequest(
      userName: 'Jane Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 5,
    ),
    FriendRequest(
      userName: 'Jane Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 5,
    ),
    FriendRequest(
      userName: 'Jane Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 5,
    ),
    // Add more friend requests here
  ];

  final List<FriendSuggestion> friendSuggestions = [
    FriendSuggestion(
      userName: 'Alice Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 3,
    ),
    FriendSuggestion(
      userName: 'Alice Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 3,
    ),
    FriendSuggestion(
      userName: 'Alice Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 3,
    ),
    FriendSuggestion(
      userName: 'Alice Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 3,
    ),
    FriendSuggestion(
      userName: 'Alice Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 3,
    ),
    FriendSuggestion(
      userName: 'Alice Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      mutualFriends: 3,
    ),
    // Add more friend suggestions here
  ];

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Call super.build to ensure AutomaticKeepAliveClientMixin works
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: ListView(
          key: PageStorageKey<String>(
              'addFriendsListView'), // Add PageStorageKey
          children: [
            _buildFriendRequests(),
            const Divider(),
            _buildFriendSuggestions(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive to return true

  Widget _buildFriendRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Friend Requests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...friendRequests
            .map((request) => _buildFriendRequestItem(request))
            .toList(),
      ],
    );
  }

  Widget _buildFriendRequestItem(FriendRequest request) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(request.userProfilePic),
              ),
              title: Text(request.userName),
              subtitle: Text('${request.mutualFriends} mutual friends'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      request.isAccepted = true;
                    });
                  },
                  child: Text('Confirm'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      friendRequests.remove(request);
                    });
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'People You May Know',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...friendSuggestions
            .map((suggestion) => _buildFriendSuggestionItem(suggestion))
            .toList(),
      ],
    );
  }

  Widget _buildFriendSuggestionItem(FriendSuggestion suggestion) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(suggestion.userProfilePic),
              ),
              title: Text(suggestion.userName),
              subtitle: Text('${suggestion.mutualFriends} mutual friends'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      friendSuggestions.remove(suggestion);
                    });
                  },
                  child: Text('Add Friend'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
