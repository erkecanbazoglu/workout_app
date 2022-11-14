import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManagerService {
  ///Checking if file is cached
  static Future<FileInfo?> checkForCache(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  ///Caches the file if not cached
  static Future<void> cacheThisUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      // print('Cached for url: $url');
    });
  }
}
