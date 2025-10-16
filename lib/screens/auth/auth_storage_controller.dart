import 'dart:convert';

import '../../general_exports.dart';

class AuthStorageController extends GetxController {
  final LocalStorage localStorage = LocalStorage();

  Future<void> saveAuthData(Map<String, dynamic>? data) async {
    final String? accessToken = data?['accessToken']?.toString();
    final String? refreshToken = data?['refreshToken']?.toString();
    // ignore: always_specify_types
    final userDataMap = data?['user'];

    if (userDataMap != null) {
      final String userDataJson = jsonEncode(userDataMap);
      await localStorage.saveToStorage(
        key: storageUserData,
        value: userDataJson,
      );
    }

    if (accessToken != null) {
      await localStorage.saveToStorage(
        key: storageAccessToken,
        value: accessToken,
      );
    }
    if (refreshToken != null) {
      await localStorage.saveToStorage(
        key: storageRefreshToken,
        value: refreshToken,
      );
    }
  }

  Future<void> clearAuthData() async {
    await localStorage.removeFromStorage(key: storageAccessToken);
    await localStorage.removeFromStorage(key: storageRefreshToken);
    await localStorage.removeFromStorage(key: storageUserData);
  }
}
