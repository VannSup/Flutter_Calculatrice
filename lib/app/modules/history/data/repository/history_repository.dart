import 'package:flutter_application_1/app/modules/history/data/provider/history_cache_provider.dart';

class HistoryRepository {
  final _historyCache = HistoryCacheProvider();

  saveResult(double result) async {
    await _historyCache.saveToCache(result);
  }

  Future<String?> retrieve() async {
    return await _historyCache.retrieveFromCache();
  }
}
