import 'package:shared_preferences/shared_preferences.dart';
import 'package:good_wallet/utils/logger.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  final log = getLogger("local_storage_service.dart");

  String authTokenDataKey = "authTokenData";

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  void saveStringToDisk(String key, String content) {
    _saveToDisk(key, content);
  }

  String getStringFromDisk(String key) {
    return _getFromDisk(key);
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    log.i('_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    log.i('_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }
}
