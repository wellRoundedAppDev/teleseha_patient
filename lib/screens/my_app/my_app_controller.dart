import '../../general_exports.dart';

class MyAppController extends GetxController {
  dynamic userData;
  LocalStorage localStorage = LocalStorage();
  String? versionName;
  String? buildNumber;
  String? refreshToken;
  bool isInternetConnect = true;
  bool shouldShowNoInternetDialog = true;
  String? myNextStep;

  final StartStepsController stepController = Get.find();

  @override
  void onInit() {
    super.onInit();
    futureRefreshLogin();
  }

  Future<void> futureRefreshLogin() async {
    await localStorage.removeFromStorage(key: storageAccessToken);
    await localStorage.removeFromStorage(key: storageRefreshToken);

    refreshToken = await localStorage.readFromStorage(storageRefreshToken);
    await ApiRequest(
      path: refreshLogin,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, dynamic>{myRefreshToken: refreshToken},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        final String? nextStep = response['nextStepEnum']?.toString();
        if (nextStep == 'CreateProfile') {
          final String? accessToken = response['data']?['accessToken']
              ?.toString();
          final String? refreshToken = response['data']?['refreshToken']
              ?.toString();
          await localStorage.saveToStorage(
            key: storageAccessToken,
            value: accessToken,
          );
          await localStorage.readFromStorage(storageAccessToken);
          await localStorage.saveToStorage(
            key: storageRefreshToken,
            value: refreshToken,
          );
          await localStorage.readFromStorage(storageRefreshToken);
          myNextStep = response['nextStepEnum']?.toString();
          update();
        } else if (nextStep == 'SelectProfile') {
          final String? accessToken = response['data']?['accessToken']
              ?.toString();
          final String? refreshToken = response['data']?['refreshToken']
              ?.toString();
          await localStorage.saveToStorage(
            key: storageAccessToken,
            value: accessToken,
          );
          await localStorage.readFromStorage(storageAccessToken);
          await localStorage.saveToStorage(
            key: storageRefreshToken,
            value: refreshToken,
          );
          await localStorage.readFromStorage(storageRefreshToken);
          myNextStep = response['nextStepEnum']?.toString();
          update();
        } else if (nextStep == 'OpenHome') {
          final String? accessToken = response['data']?['accessToken']
              ?.toString();
          final String? refreshToken = response['data']?['refreshToken']
              ?.toString();
          await localStorage.saveToStorage(
            key: storageAccessToken,
            value: accessToken,
          );
          await localStorage.readFromStorage(storageAccessToken);
          await localStorage.saveToStorage(
            key: storageRefreshToken,
            value: refreshToken,
          );
          await localStorage.readFromStorage(storageRefreshToken);
          myNextStep = response['nextStepEnum']?.toString();
          update();
        }
      },
      // ignore: always_specify_types
      onError: (error) {
        localStorage.removeFromStorage(key: storageAccessToken).then((_) {
          localStorage.removeFromStorage(key: storageRefreshToken).then((_) {
            Get.toNamed(routeFingerPrint);
          });
        });
        return null;
      },
    );
  }

  void onSignOut() {
    userData = null;
    update();
  }

  void onUserAuthenticated(dynamic userDataValue) {
    userData = userDataValue;
    update();
  }
}
