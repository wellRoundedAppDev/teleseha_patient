import 'dart:async';

import 'package:dio/dio.dart';

import '../../../general_exports.dart' hide FormData;

class DetailsAboutYouController extends GetxController {
  final TextEditingController myJobTitle = TextEditingController();
  bool showjobTitleError = false;
  String jobTitleErrorMessage = '';

  final TextEditingController length = TextEditingController();
  bool showLengthError = false;
  String lengthErrorMessage = '';

  final TextEditingController weight = TextEditingController();
  bool showWeightError = false;
  String weightMessage = '';

  bool isLoading = false;

  String? selectedValue;

  // ignore: always_specify_types
  List countrys = <dynamic>[];
  // ignore: always_specify_types
  List states = <dynamic>[];
  List<dynamic> myCity = <dynamic>[];
  List<dynamic> myMaritalStatus = <dynamic>[];

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedMaritalStatus;
  int? selectedCityId;
  String? accessToken;

  LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    _patient();
  }

  Future<void> _patient() async {
    isLoading = true;
    update();

    await ApiRequest(
      path: infoLists,
      className: '',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        isLoading = false;
        countrys = response['countries'] ?? <dynamic>[];
        myMaritalStatus = response['maritalStatus'] ?? <dynamic>[];
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        isLoading = false;
        update();
        return null;
      },
    );
  }

  void selectCountry(String newCountryName) {
    selectedCountry = newCountryName;

    // ignore: always_specify_types
    final selectedCountryObj = countrys.firstWhere(
      // ignore: always_specify_types
      (country) => country['countryName'] == newCountryName,
      orElse: () => null,
    );

    if (selectedCountryObj != null) {
      states = selectedCountryObj['states'] ?? <dynamic>[];
      selectedState = null;
    }

    update();
  }

  void selectState(String newStateName) {
    selectedState = newStateName;
    myCity = <dynamic>[];

    // ignore: always_specify_types
    for (var country in countrys) {
      // ignore: always_specify_types
      final countryStates = country['states'] ?? <dynamic>[];
      // ignore: always_specify_types
      final foundState = countryStates.firstWhere(
        // ignore: always_specify_types
        (state) => state['stateName'] == newStateName,
        orElse: () => null,
      );
      if (foundState != null) {
        selectedCountry = country['countryName'];
        states = countryStates;
        myCity = foundState['cities'] ?? <dynamic>[];
        break;
      }
    }
    selectedCity = null;
    update();
  }

  void selectCity(String newCityName) {
    selectedCity = newCityName;

    // ignore: always_specify_types
    final selectedCityObj = myCity.firstWhere(
      // ignore: always_specify_types
      (city) => city['cityName'] == newCityName,
      orElse: () => null,
    );

    if (selectedCityObj != null) {
      selectedCityId = selectedCityObj['cityId'];
    }

    update();
  }

  void updateSelectedMaritalStatus(String newValue) {
    selectedMaritalStatus = newValue;
    update();
  }

  Future<void> putPatient() async {
    final StartStepsController stepsController =
        Get.find<StartStepsController>();

    accessToken = await localStorage.readFromStorage(storageAccessToken);

    isLoading = true;
    update();

    final FormData formData = FormData.fromMap(<String, dynamic>{
      keyName: stepsController.name,
      isMale: stepsController.myIsMale,
      maritalStatus: selectedMaritalStatus,
      date: stepsController.barthDay,
      jobTitle: myJobTitle.text.trim(),
      myState: selectedState,
      city: selectedCity,
      cityId: selectedCityId,
    });

    await ApiRequest(
      path: '$patient/${stepsController.patientId}',
      className: '',
      formatResponse: true,
      method: ApiMethods.put,
      body: formData,
      header: <String, dynamic>{
        'Content-Type': 'multipart/from-data',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        isLoading = false;
        Get.toNamed(routeScreen);
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        isLoading = false;
        Get.snackbar(
          'فشل الحفظ',
          'لم يتم التخزين',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        update();
        return null;
      },
    );
  }
}
