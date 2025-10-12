import 'dart:async';

import 'package:dio/dio.dart';
import '../../../general_exports.dart' hide FormData;

class PayMobManager {
  // Future<String> getPaymentKey(int amount, String currency) async {
  //   final String authanticationRequest = await _getAuthanticatToken();
  //   await _orderRegitstartionApi(
  //     amount: (amount * 100).toInt().toString(),
  //     authanticationToken: authanticationRequest,
  //     currency: currency,
  //   );
  //   final String paymentKey = await _getpenyKey();
  //   return paymentKey;
  // }

  String? accessToken;
  final LocalStorage localStorage = LocalStorage();

  // ignore: always_specify_types
  Future payment(loukMyPatientId, doctorId) async {
    final FormData formData = FormData.fromMap(<String, dynamic>{
      complaintId: '0',
      myPatientId: loukMyPatientId,
      myDoctorId: doctorId,
      isReceiptionPayment: true,
    });

    accessToken = await localStorage.readFromStorage(storageAccessToken);

    ApiRequest(
      path: paymentPath,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: formData,
      header: <String, dynamic>{
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken',
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        final List<Map<String, dynamic>> dataResponse =
            List<Map<String, dynamic>>.from(data);
        response = dataResponse;
      },
      // ignore: always_specify_types
      onError: (error) {
        return null;
      },
    );
  }

  // Future<String> _getAuthanticatToken() async {
  //   startLoading();
  //   final String response = '';
  //   ApiRequest(
  //     // path: authontication,
  //     className: '',
  //     formatResponse: true,
  //     method: ApiMethods.post,
  //     body: {'api_key': 'apiKey'},
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) {
  //       final List<Map<String, dynamic>> dataResponse =
  //           List<Map<String, dynamic>>.from(data);
  //       response = dataResponse;
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       return null;
  //     },
  //   );
  //   return response;
  // }

  // Future<int> _orderRegitstartionApi({
  //   required String authanticationToken,
  //   required String amount,
  //   required String currency,
  // }) async {
  //   startLoading();
  //   final int response = 1;
  //   ApiRequest(
  //     // path: authontication,
  //     className: '',
  //     formatResponse: true,
  //     method: ApiMethods.post,
  //     body: {
  //       'auth_token': authanticationToken,
  //       'amount_cents': amount,
  //       'delivery_needed': currency,
  //       'items': <dynamic>[],
  //     },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) {
  //       final List<Map<String, dynamic>> dataResponse =
  //           List<Map<String, dynamic>>.from(data);
  //       dismissLoading();
  //       response = dataResponse;
  //       // .data[idPaymob]
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       dismissLoading();
  //       return null;
  //     },
  //   );
  //   return response;
  // }

  // // ignore: always_specify_types
  // Future _getpenyKey() async {
  //   startLoading();
  //   final int response = 1;
  //   ApiRequest(
  //     // path: authontication,
  //     className: '',
  //     formatResponse: true,
  //     method: ApiMethods.post,
  //     body: <dynamic, dynamic>{
  //       // create aonly somethings and response token to create method payment
  //     },
  //   ).request(
  //     onSuccess: (dynamic data, dynamic response) {
  //       final List<Map<String, dynamic>> dataResponse =
  //           List<Map<String, dynamic>>.from(data);
  //       dismissLoading();
  //       response = dataResponse;
  //       // .data[payMobToken]
  //     },
  //     // ignore: always_specify_types
  //     onError: (error) {
  //       dismissLoading();
  //       return null;
  //     },
  //   );
  //   return response;
  // }
}
