import '../../general_exports.dart';

class SettingsController extends GetxController {
  bool isLoading = false;
  String? refreshToken;
  LocalStorage localStorage = LocalStorage();

  Future<void> logOut() async {
    isLoading = true;
    update();

    refreshToken = await localStorage.readFromStorage(storageRefreshToken);

    await ApiRequest(
      path: logout,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
      body: <String, String?>{myRefreshToken: refreshToken},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        update();
        await localStorage.removeFromStorage(key: storageAccessToken);
        await localStorage.removeFromStorage(key: storageRefreshToken);
        Get.toNamed(routeFingerPrint);
      },
      // ignore: always_specify_types
      onError: (error) {
        isLoading = false;
        update();
        return null;
      },
    );
  }
}
