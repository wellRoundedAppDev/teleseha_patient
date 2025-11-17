import '../../general_exports.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndexBottomNav = 2.obs;

  // final double widthSelected = DEVICE_WIDTH <= 380 ? 75 : 85;
  // final double horizontalMargin = DEVICE_WIDTH <= 380 ? 0 : 8;

  final List<String> labels = <String>[
    'personal_page'.tr,
    'reports'.tr,
    'home'.tr,
    'doctors'.tr,
    'settings'.tr,
  ];

  final List<Widget> pages = <Widget>[
    const Mypage(),
    Reports(),
    const HomePageContent(),
    const HomePageContent(),
    const Settings(),
  ];

  // ignore: always_specify_types
  final List icons = <dynamic>[
    iconPersonal,
    iconReports,
    iconHome,
    iconDoctors,
    iconSettings,
  ];

  void changeIndex(int index) {
    selectedIndexBottomNav.value = index;
    final ChangeParamContentAndNextPage changeParam = Get.find();

    index == 2
        ? changeParam.goToComponentHeader.value = 'HomePage'
        : index == 3
        ? changeParam.goToComponentHeader.value = 'Doctors'
        // ignore: unnecessary_statements
        : '';

    changeParam.update();
    update();
  }

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
        Get.toNamed(routeLogin);
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
