import '../../general_exports.dart';

class ReportsController extends GetxController {
  int isSelected = 0;
  final double widthSelected = DEVICE_WIDTH <= 380 ? 0.45 : 0.48;
  final double sizeTextSelected = DEVICE_WIDTH <= 380 ? 11 : 12;
  RxList<String> heHasExperienceIn = <String>[].obs;
  int? passedIndex = 0;
  int? get selectedDoctorId => passedIndex;

  bool isLoading = false;
  String? accessToken;

  LocalStorage localStorage = LocalStorage();

  final List<String> tabs = <String>[
    'prescriptions'.tr,
    'the_radiology'.tr,
    'analyses'.tr,
  ];

  double calculateWidth(String text) {
    return text.length * 3 + 1;
  }

  @override
  void onInit() {
    super.onInit();
    _listLabAnalysisRequestData();
    // _reportsData();
  }

  // ignore: always_specify_types
  // List lastReportsData = <dynamic>[];
  // Future<void> _reportsData() async {
  //   isLoading = true;
  //   update();
  //   accessToken = await localStorage.readFromStorage(storageAccessToken);
  //   await ApiRequest(
  //     path: '$reportsMeeting/1',
  //     className: '',
  //     formatResponse: true,
  //     header: <String, dynamic>{
  //       'Content-Type': 'application/json',
  //       'Accept': '*/*',
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) async {
  //       lastReportsData = response ?? <dynamic>[];
  //       update();
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       // specialtiesWithSub = 'not_found_medical_profile_section'.tr;
  //       update();
  //       return null;
  //     },
  //   );
  //   isLoading = false;
  //   update();
  // }

  // ignore: always_specify_types
  List listLabAnalysisRequest = <dynamic>[];
  Future<void> _listLabAnalysisRequestData() async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: labAnalysisRequest,
      className: '',
      formatResponse: true,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        listLabAnalysisRequest = response ?? <dynamic>[];
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  // ignore: always_specify_types
  List doctors = <dynamic>[
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'date_revelation': 'date_revelation'.tr,
    },
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'date_revelation': 'date_revelation'.tr,
    },
    <String, Object>{
      'id': 1,
      'image': imageDoctor,
      'name': 'name_doctor1'.tr,
      'specialization': 'general_internal_affairs'.tr,
      'range': '4.9',
      'date_revelation': 'date_revelation'.tr,
    },
  ];
}
