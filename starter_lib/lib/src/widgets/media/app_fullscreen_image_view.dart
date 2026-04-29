import 'package:flutter/material.dart';

class AppFullscreenImageView extends StatelessWidget {
  const AppFullscreenImageView({
    super.key,
    required this.imageUrl,
    this.heroTag,
    this.backgroundColor = Colors.black,
    this.fit = BoxFit.contain,
  });

  final String imageUrl;
  final String? heroTag;
  final Color backgroundColor;
  final BoxFit fit;

  static Future<void> showNetwork(
    BuildContext context, {
    required String imageUrl,
    String? heroTag,
    BoxFit fit = BoxFit.contain,
  }) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => AppFullscreenImageView(
          imageUrl: imageUrl,
          heroTag: heroTag,
          fit: fit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = InteractiveViewer(
      minScale: 1,
      maxScale: 4,
      child: Image.network(
        imageUrl,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
      ),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: heroTag == null ? image : Hero(tag: heroTag!, child: image),
        ),
      ),
    );
  }
}
