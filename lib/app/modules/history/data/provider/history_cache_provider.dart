import 'package:flutter_application_1/core/cache/cache_helper.dart';

class HistoryCacheProvider {
  final CacheHelper _helper = CacheHelper();

  saveToCache(double result) async {
    await _helper.save('last_result', result.toString());
  }

  retrieveFromCache() async {
    final String? result = await _helper.read('last_result');
    return result;
  }
}
