import 'dart:async';
import 'dart:convert' show jsonDecode;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../general_exports.dart' hide FormData;
import '../../../services/signalr_service.dart';

class BookingsController extends GetxController {
  int? passedIndex = 0;
  int? get selectedRecentBookingsId => passedIndex;
  // ignore: always_specify_types
  Map? selectedLastRecent;
  int currentStep = 0;
  final int totalSteps = 5;
  int remainingMinutes = 1;
  bool isLoading = false;
  String? accessToken;
  int? loukMyPatientId;
  final ChangeParamContentAndNextPage change = Get.find();
  // String? nameAndGoNextPageInBtn;
  // bool showHeaderBtn = true;
  bool hasLoadedSessionWaiting = false;
  int? mySectionId;
  int selectedIndex = -1;

  List<String> rates = <String>['25%', '50%', '75%', '100%'];

  void selectRate(int index) {
    selectedIndex = index;
    update();
  }

  LocalStorage localStorage = LocalStorage();

  final SignalRService signalRService = SignalRService();

  @override
  void onInit() {
    _loadUserName();
    _comming();

    Timer.periodic(const Duration(seconds: 20), (Timer timer) {
      remainingMinutes > 0 ? remainingMinutes-- : timer.cancel();
      // ignore: unnecessary_statements
      remainingMinutes == 10 || remainingMinutes == 0 ? currentStep = 2 : null;
      update();
    });

    super.onInit();
  }

  Future<void> _loadUserName() async {
    final String? userJson = await localStorage.readFromStorage(
      storageUserData,
    );

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final String? name = userMap['patients']?[0]?['name'];
      final int? patientId = userMap['patients']?[0]?['patientId'];
      if (name != null && name.isNotEmpty) {
        loukMyPatientId = patientId;
      }
    }
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      final String formatted = DateFormat('dd MMMM', 'ar').format(date);
      return formatted;
    } catch (e) {
      return 'تاريخ غير صالح';
    }
  }

  String getSafeTime(dynamic start) {
    if (start == null || start.toString().isEmpty) {
      return '--:--';
    }
    final String value = start.toString();
    return value.length >= 5 ? value.substring(0, 5) : value;
  }

  // ignore: always_specify_types
  List lastRecent = <dynamic>[];
  Future<void> _comming() async {
    try {
      isLoading = true;
      update();

      accessToken = await localStorage.readFromStorage(storageAccessToken);

      await ApiRequest(
        path: '$comming/$loukMyPatientId',
        className: '',
        formatResponse: true,
        header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
      ).request(
        // ignore: always_specify_types
        onSuccess: (data, response) async {
          // ignore: always_specify_types
          lastRecent = (response ?? <dynamic>[]) as List;
          // ignore: always_specify_types
          for (final item in lastRecent) {
            String btnName = '';
            bool showBtn = false;

            switch (item['status']) {
              case 'Confirmed':
                btnName = 'buy'.tr;
                showBtn = true;
                break;
              case 'CreateComplaint':
                btnName = 'send_ai'.tr;
                showBtn = true;
                break;
              case 'Pending':
                btnName = 'page_wating'.tr;
                showBtn = true;
                break;
              case 'Started':
                btnName = 'improvement_rate'.tr;
                showBtn = true;
                break;
              default:
                btnName = '';
                showBtn = false;
            }

            item['buttonName'] = btnName;
            item['showButton'] = showBtn;
          }

          isLoading = false;
          update();
        },
        // ignore: always_specify_types
        onError: (error) {
          isLoading = false;
          update();
          return null;
        },
      );
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  Future<void> _pay(int id) async {
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);

    final FormData formData = FormData.fromMap(<String, dynamic>{
      appointmentId: id,
    });

    await ApiRequest(
      path: '$paymentPath/$id',
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: formData,
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        // ignore: always_specify_types
        consoleLog('success');
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        final int? statusCode = error.response?.statusCode;
        isLoading = false;
        update();
        if (statusCode == 401) {
          final LoginController appController = Get.find();
          appController.futureRefreshLogin();
        }
        return null;
      },
    );
  }

  Future<void> changeAvailableBtn(String status, int id, int secionId) async {
    switch (status) {
      case 'Confirmed':
        signalRService
            .initConnection(
              // $id
              'https://teleseha.com/hubs/appointment?appointmentid=76',
              'Bearer $accessToken',
            )
            .then((_) {
              change.goToComponentHeader.value = 'waitingForYourTurn';
              change.update();
            })
            // ignore: always_specify_types
            .catchError((error) {
              print(error);
            });
        _pay(id);
        break;

      case 'CreateComplaint':
        // final ChatGeminiController chatController = Get.put(
        //   ChatGeminiController(),
        // );
        // chatController.gemeiniStart(id);
        // change.goToComponentHeader.value = 'ChatGemini';
        // change.update();

        signalRService
            .initConnection(
              // $id
              'https://teleseha.com/hubs/appointment?appointmentid=76',
              'Bearer $accessToken',
            )
            .then((_) {
              change.goToComponentHeader.value = 'waitingForYourTurn';
              change.update();
            })
            // ignore: always_specify_types
            .catchError((error) {
              print(error);
            });

        break;

      case 'Pending':
        // Get.toNamed(meetingPage);
        mySectionId = secionId;
        signalRService
            .initConnection(
              // $id
              'https://teleseha.com/hubs/appointment?appointmentid=76',
              'Bearer $accessToken',
            )
            .then((_) {
              change.goToComponentHeader.value = 'waitingForYourTurn';
              change.update();
            })
            // ignore: always_specify_types
            .catchError((error) {
              print(error);
            });
        break;
      case 'Started':
        Get.dialog(
          GetBuilder<BookingsController>(
            builder: (controller) {
              return AlertDialog(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        iconClose,
                        width: 12,
                        height: 12,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.03),
                    Align(
                      child: CustomText(
                        text: 'text_improvement_rate'.tr,
                        fontSize: 16,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorLineAndText),
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(controller.rates.length, (index) {
                        final bool isSelected =
                            controller.selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            controller.selectRate(index);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: DEVICE_WIDTH * 0.015,
                            ),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2E6FF3)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: isSelected
                                    ? const Color(0xFF2E6FF3)
                                    : const Color.fromARGB(113, 139, 139, 139),
                              ),
                            ),
                            child: Center(
                              child: CustomText(
                                text: controller.rates[index].tr,
                                fontSize: 11,
                                type: CustomTextType.title,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(AppColors.colorTextSkep),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Btn(
                      customHeight: 0.07,
                      onPressed: () {},
                      text: 'send'.tr,
                    ),
                  ),
                ],
              );
            },
          ),
          barrierDismissible: false,
        );
        break;
      case 'Created':
        break;

      default:
        Get.snackbar('تنبيه', 'لا يوجد إجراء لهذه الحالة');
    }
  }

  Future<void> chatPostRequest() async {
    await ApiRequest(
      path: ratingReview,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      header: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
      body: <String, Object>{
        rating: 3,
        review: 'string',
        callTimeRating: 3,
        isFirstAdvantage: true,
        isSecondAdvantage: true,
        isThirdAdvantage: true,
        checkupId: 123,
        doctorId: 2,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        isLoading = false;
        // Get.toNamed(details);
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

  // ignore: always_specify_types
  List watingData = <dynamic>[];
  Future<void> sessionWaitingData() async {
    if (hasLoadedSessionWaiting) {
      return;
    }
    hasLoadedSessionWaiting = true;
    isLoading = true;
    update();
    accessToken = await localStorage.readFromStorage(storageAccessToken);
    await ApiRequest(
      path: '$session/$mySectionId',
      className: '',
      formatResponse: true,
      header: <String, dynamic>{'Authorization': 'Bearer $accessToken'},
    ).request(
      onSuccess: (dynamic data, dynamic response) async {
        watingData = response ?? <dynamic>[];
        update();
      },
      // ignore: always_specify_types
      onError: (error) {
        // specialties = 'not_found_medical_profile_section'.tr;
        update();
        return null;
      },
    );
    isLoading = false;
    update();
  }

  // void selectedLastRecentFunction() {
  //   selectedLastRecent = lastRecent.firstWhere(
  //     // ignore: non_constant_identifier_names, always_specify_types
  //     (LastRecent) => LastRecent['id'] == selectedRecentBookingsId,
  //     orElse: () => <dynamic, dynamic>{},
  //   );
  // }
}
