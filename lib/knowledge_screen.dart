import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class VideoMetadata {
  final String title;
  final String videoUrl;

  VideoMetadata({required this.title, required this.videoUrl});
}

class KnowledgeScreen extends StatefulWidget {
  @override
  _KnowledgeScreenState createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  late VideoPlayerController _controller;
  List<VideoMetadata> videoMetadataList = [];

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network('gs://myproj-926c3.appspot.com/kid.mp4');
    _controller = VideoPlayerController.network(
        'gs://myproj-926c3.appspot.com/kidss.mp4');
    _controller =
        VideoPlayerController.network('gs://myproj-926c3.appspot.com/kids.mp4');

    _initializeVideo(0);
  }

  Future<void> _initializeVideo(int index) async {
    // Get the video URL from the list of video metadata
    final videoUrl = videoMetadataList[index].videoUrl;

    // Initialize the VideoPlayerController with the video URL
    _controller = VideoPlayerController.network(videoUrl);

    // Ensure the video is initialized, set volume, and start playing
    await _controller.initialize();
    await _controller.setVolume(1.0);
    await _controller.play();

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        if (index < videoMetadataList.length - 1) {
          // Move to the next video when the current one ends
          setState(() {
            _controller.pause();
            _initializeVideo(index + 1);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Screen'),
      ),
      body: FutureBuilder<void>(
        future: _fetchVideoMetadata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                ListTile(
                  title: Text(videoMetadataList.isNotEmpty
                      ? videoMetadataList.first.title
                      : 'No videos available'),
                ),
                // Add interaction buttons or swipe gestures for navigation
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _fetchVideoMetadata() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot =
        await firestore.collection('videos').get();

    videoMetadataList = querySnapshot.docs
        .map((doc) => VideoMetadata(
              title: doc['title'] ?? '',
              videoUrl: doc['videoUrl'] ?? '',
            ))
        .toList();

    setState(() {
      if (videoMetadataList.isNotEmpty) {
        _controller.dispose();
        _controller =
            VideoPlayerController.network(videoMetadataList.first.videoUrl);
        _initializeVideo(0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KnowledgeScreen(),
    );
  }
}
