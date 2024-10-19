import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Message/message_page.dart';
import 'main_screen/Friends/friends_page.dart';
import 'main_screen/Home/home_page.dart';
import 'main_screen/Reels/reels_page.dart';

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: TabBar(
                  labelColor: Colors.amber[800],
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.amber[800],
                  tabs: const [
                    Tab(icon: Icon(Icons.home), text: 'Home'),
                    Tab(icon: Icon(Icons.person_add), text: 'Friends'),
                    Tab(icon: Icon(Icons.message), text: 'Messages'),
                    Tab(icon: FaIcon(FontAwesomeIcons.film), text: 'Reels'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    HomeFeeds(),
                    AddFriendsPage(),
                    MessagesPage(),
                    ReelsPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Page'),
    );
  }
}
