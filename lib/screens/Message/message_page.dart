import 'package:flutter/material.dart';

import '../../models/message_model.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with AutomaticKeepAliveClientMixin {
  final PageStorageBucket _bucket = PageStorageBucket();
  final ScrollController _scrollController = ScrollController();

  final List<Message> messages = [
    Message(
      userName: 'Jane Doe',
      userProfilePic: 'https://via.placeholder.com/150',
      messagePreview: 'Hey, how are you?',
      time: '2 hours ago',
    ),
    Message(
      userName: 'John Smith',
      userProfilePic: 'https://via.placeholder.com/150',
      messagePreview: 'Let\'s catch up soon!',
      time: '3 hours ago',
    ),
    // Add more messages here
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Call super.build to ensure AutomaticKeepAliveClientMixin works
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: PageStorage(
        bucket: _bucket,
        child: ListView.builder(
          key: PageStorageKey<String>('messagesListView'), // Add PageStorageKey
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(messages[index]);
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive to return true

  Widget _buildMessageItem(Message message) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(message.userProfilePic),
        ),
        title: Text(message.userName),
        subtitle: Text(message.messagePreview),
        trailing: Text(message.time),
        onTap: () {
          // Handle message tap
        },
      ),
    );
  }
}
