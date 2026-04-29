import 'package:flutter/widgets.dart';

class AppImageCacheService {
  AppImageCacheService._();

  static Future<void> precacheNetworkImage(
    BuildContext context,
    String imageUrl, {
    double scale = 1.0,
    Map<String, String>? headers,
  }) async {
    if (imageUrl.trim().isEmpty) {
      return;
    }

    final NetworkImage provider = NetworkImage(
      imageUrl,
      scale: scale,
      headers: headers,
    );
    await precacheImage(provider, context);
  }

  static Future<void> precacheNetworkImages(
    BuildContext context,
    Iterable<String> imageUrls, {
    double scale = 1.0,
    Map<String, String>? headers,
  }) async {
    final List<Future<void>> tasks = <Future<void>>[];

    for (final String url in imageUrls) {
      if (url.trim().isEmpty) {
        continue;
      }

      tasks.add(
        precacheNetworkImage(
          context,
          url,
          scale: scale,
          headers: headers,
        ),
      );
    }

    if (tasks.isNotEmpty) {
      await Future.wait(tasks);
    }
  }

  static Future<void> precacheAssetImage(
    BuildContext context,
    String assetPath,
  ) async {
    if (assetPath.trim().isEmpty) {
      return;
    }

    await precacheImage(AssetImage(assetPath), context);
  }

  static Future<void> precacheAssetImages(
    BuildContext context,
    Iterable<String> assetPaths,
  ) async {
    final List<Future<void>> tasks = <Future<void>>[];

    for (final String path in assetPaths) {
      if (path.trim().isEmpty) {
        continue;
      }

      tasks.add(precacheAssetImage(context, path));
    }

    if (tasks.isNotEmpty) {
      await Future.wait(tasks);
    }
  }

  static void configureImageCache({
    int? maximumSize,
    int? maximumSizeBytes,
  }) {
    final ImageCache cache = PaintingBinding.instance.imageCache;

    if (maximumSize != null && maximumSize > 0) {
      cache.maximumSize = maximumSize;
    }

    if (maximumSizeBytes != null && maximumSizeBytes > 0) {
      cache.maximumSizeBytes = maximumSizeBytes;
    }
  }

  static Future<void> evictNetworkImage(
    String imageUrl, {
    double scale = 1.0,
  }) async {
    if (imageUrl.trim().isEmpty) {
      return;
    }

    final NetworkImage provider = NetworkImage(imageUrl, scale: scale);
    await provider.evict();
  }

  static Future<void> evictAssetImage(String assetPath) async {
    if (assetPath.trim().isEmpty) {
      return;
    }

    final AssetImage provider = AssetImage(assetPath);
    await provider.evict();
  }

  static void clearAll() {
    final ImageCache cache = PaintingBinding.instance.imageCache;
    cache.clear();
    cache.clearLiveImages();
  }
}
