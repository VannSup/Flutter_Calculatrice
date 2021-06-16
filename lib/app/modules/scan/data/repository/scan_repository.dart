import 'package:flutter_application_1/app/modules/scan/data/provider/scan_cache_provider.dart';

class ScanRepository {
  final _scanCacheProvider = ScanCacheProvider();

  Future saveScan(String path) async {
    await _scanCacheProvider.saveScanToCache(path);
  }

  Future<String?> retrieveScan() async {
    return await _scanCacheProvider.retrieveScanFromCache();
  }

  logout() async {
    await _scanCacheProvider.removeScanFromCache();
  }
}