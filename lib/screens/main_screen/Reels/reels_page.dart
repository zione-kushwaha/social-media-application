import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<String> reelUrls = [
    'https://firebasestorage.googleapis.com/v0/b/randoms-1a9e8.appspot.com/o/chat%2Fvideo%2FNjlfuyRt3nchZsEab2sHcpxkvrX2%2FNjlfuyRt3nchZsEab2sHcpxkvrX2%2Fa5abde60-be6d-1110-9df9-9fffdeaf9ed3?alt=media&token=2425cfbc-b656-42f4-8131-3a2898deec20', // Replace with actual video URLs
    'https://firebasestorage.googleapis.com/v0/b/randoms-1a9e8.appspot.com/o/chat%2Fvideo%2FNjlfuyRt3nchZsEab2sHcpxkvrX2%2FNjlfuyRt3nchZsEab2sHcpxkvrX2%2Fa5abde60-be6d-1110-9df9-9fffdeaf9ed3?alt=media&token=2425cfbc-b656-42f4-8131-3a2898deec20',
    'https://firebasestorage.googleapis.com/v0/b/randoms-1a9e8.appspot.com/o/chat%2Fvideo%2FNjlfuyRt3nchZsEab2sHcpxkvrX2%2FNjlfuyRt3nchZsEab2sHcpxkvrX2%2Fa5abde60-be6d-1110-9df9-9fffdeaf9ed3?alt=media&token=2425cfbc-b656-42f4-8131-3a2898deec20',
  ];

  late PageController _pageController;
  late List<VideoPlayerController> _videoControllers;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers = reelUrls
        .map((url) => VideoPlayerController.network(url)
          ..initialize().then((_) {
            setState(() {}); // Update after video initializes
          })
          ..setLooping(true) // Loop the video
          ..play()) // Auto-play the video
        .toList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Scroll vertically for reels effect
        controller: _pageController,
        itemCount: reelUrls.length,
        itemBuilder: (context, index) {
          final controller = _videoControllers[index];

          if (!controller.value.isInitialized) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Video Player
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size?.width ?? 0,
                    height: controller.value.size?.height ?? 0,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),

              // Overlay with User Info and Interactions (like, comment, etc.)
              Positioned(
                bottom: 50,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username $index', // Replace with dynamic data
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description for reel $index', // Replace with dynamic data
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: Colors.white),
                            SizedBox(width: 10),
                            Icon(Icons.comment, color: Colors.white),
                            SizedBox(width: 10),
                            Icon(Icons.share, color: Colors.white),
                          ],
                        ),
                        Icon(Icons.more_vert, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
