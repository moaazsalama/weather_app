import 'package:flutter/material.dart';
import 'package:weather_app/core/helper/string_extension.dart';

class AnimatedImage extends StatefulWidget {
  final String imagePath;
  const AnimatedImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _animation = Tween<double>(begin: 0, end: 10).animate(_controller!);
    _controller?.addListener(() {
      // print(_animation!.value);
      setState(() {});
    });
    _controller?.forward();
    _controller?.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: const Duration(milliseconds: 500),

      padding: EdgeInsets.only(top: _animation!.value),
      child:
          Image.network(widget.imagePath.weatherIconUrl, fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.network_check);
      }),
    );
  }
}
