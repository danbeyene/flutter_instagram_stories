import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_instagram_stories/video_controller_service.dart';
import 'package:video_player/video_player.dart';

// ignore_for_file: must_be_immutable
class VideoPlayerCard extends StatefulWidget {
  VideoPlayerCard(
      {super.key,
      required this.videoUrl,
      this.isDarkMode,
      required this.width,
      required this.height});
  String? videoUrl;
  bool? isDarkMode;
  double height;
  double width;

  @override
  State<VideoPlayerCard> createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<VideoPlayerCard> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    if (widget.videoUrl != null) {
      CachedVideoControllerService cachedVideoControllerService =
          CachedVideoControllerService(DefaultCacheManager());
      // _videoPlayerController =
      //     VideoPlayerController.network(widget.videoModel.url!);
      _videoPlayerController = await cachedVideoControllerService
          .getControllerForVideo(widget.videoUrl!);
      await _videoPlayerController?.initialize();
      if (mounted) {
        setState(() {});
      }
      // Logger.log('video player restarted to ========================= ${widget.videoModel.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _videoPlayerController!=null && _videoPlayerController!.value.isInitialized
          ? Center(
              child: SizedBox(
                height: widget.height,
                width: widget.width,
                child: VideoPlayer(_videoPlayerController!),
                // child: Chewie(
                //   controller: _chewieController!,
                // ),
              ),
            )
          : Container(
              color: widget.isDarkMode == true ? Colors.black : Colors.white,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color:
                        widget.isDarkMode == true ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 20),
                  Text('Loading',
                      style: widget.isDarkMode == true
                          ? TextStyle(color: Colors.white)
                          : TextStyle(color: Colors.black)),
                ],
              ),
            ),
    );
  }
}
