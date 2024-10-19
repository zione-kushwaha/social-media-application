import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../../models/users_post.dart';

class HomeFeeds extends StatefulWidget {
  const HomeFeeds({super.key});

  @override
  _HomeFeedsState createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds>
    with AutomaticKeepAliveClientMixin {
  final PageStorageBucket _bucket = PageStorageBucket();
  StoryController _storyController = StoryController();

  final List<Post> posts = [
    Post(
      userName: 'John Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      postTime: '2 hours ago',
      postContent:
          'This is a sample post content. Replace with actual post content.',
      postImage: 'https://via.placeholder.com/300',
      likes: 10,
      comments: 5,
      shares: 2,
    ),
    Post(
      userName: 'John Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      postTime: '2 hours ago',
      postContent:
          'This is a sample post content. Replace with actual post content.',
      postImage: 'https://via.placeholder.com/300',
      likes: 10,
      comments: 5,
      shares: 2,
    ),
    Post(
      userName: 'John Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      postTime: '2 hours ago',
      postContent:
          'This is a sample post content. Replace with actual post content.',
      postImage: 'https://via.placeholder.com/300',
      likes: 10,
      comments: 5,
      shares: 2,
    ),
    // Add more posts here
  ];

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Call super.build to ensure AutomaticKeepAliveClientMixin works
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: ListView(
          key:
              PageStorageKey<String>('homeFeedsListView'), // Add PageStorageKey
          children: [
            _buildStoryList(),
            const Divider(),
            ...posts.map((post) => _buildPost(post)),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive to return true

  Widget _buildStoryList() {
    return Container(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAddPostOption(),
          ...List.generate(5, (index) => _buildStoryItem(index)),
        ],
      ),
    );
  }

  Widget _buildAddPostOption() {
    return Container(
      width: 80,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // Handle add post action
          },
        ),
      ),
    );
  }

  Widget _buildStoryItem(int index) {
    return GestureDetector(
      onTap: () {
        _showStoryView(index);
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Story $index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showStoryView(int index) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: StoryView(
            storyItems: [
              StoryItem.text(
                title: "Welcome to the Story View",
                backgroundColor: Colors.blue,
              ),
              StoryItem.pageImage(
                url: "https://via.placeholder.com/150",
                controller: _storyController,
              ),
              StoryItem.pageImage(
                url: "https://via.placeholder.com/150",
                controller: _storyController,
              ),
            ],
            controller: _storyController,
            repeat: false,
            onComplete: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    )
        .then((_) {
      // Reset the StoryController when the StoryView is closed
      _storyController.dispose();
      setState(() {
        _storyController = StoryController();
      });
    });
  }

  Widget _buildPost(Post post) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.userProfilePic),
            ),
            title: Text(post.userName),
            subtitle: Text(post.postTime),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.postContent),
          ),
          Center(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(15.0), // Adjust the value for roundness
              child: Image.network(
                post.postImage,
                width: double.infinity,
                fit: BoxFit.cover, // Ensures the image covers the space
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.thumb_up),
                label: Text('${post.likes}'),
                onPressed: () {
                  setState(() {
                    post.likes++;
                  });
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.comment),
                label: Text('${post.comments}'),
                onPressed: () {
                  // Handle comment action
                },
              ),
              TextButton.icon(
                icon: Transform.rotate(
                  angle: 3.14, // Rotate by 180 degrees (pi radians)
                  child: const Icon(Icons.reply),
                ),
                label: Text('${post.shares}'),
                onPressed: () {
                  setState(() {
                    post.shares++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
