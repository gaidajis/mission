import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatelessWidget {
  final ChewieController? chewieController;

  const VideoPlayerWidget({super.key, this.chewieController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: chewieController != null
          ? Chewie(controller: chewieController!)
          : const CircularProgressIndicator(),
    );
  }
}
