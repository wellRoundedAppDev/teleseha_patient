// import '../../../general_exports.dart';

// class PayMobManager {
//   Future<String> getPaymentKey(int amount, String currency) async {
//     String authanticationRequest = await _getAuthanticatToken();
//     int orderId = await _orderRegitstartionApi(
//       amount: (100 * amount).toString(),
//       authanticationToken: authanticationRequest,
//       currency: currency,
//     );
//     String paymentKey = await _getpenyKey();
//     return paymentKey;
//   }

//   Future<String> _getAuthanticatToken() async {
//     startLoading();
//     String response = '';
//     ApiRequest(
//       // path: authontication,
//       className: '',
//       formatResponse: true,
//       method: ApiMethods.post,
//       body: {"api_key": "apiKey"},
//     ).request(
//       onSuccess: (dynamic data, dynamic response) {
//         var dataResponse = List<Map<String, dynamic>>.from(data);
//         dismissLoading();
//         response = dataResponse;
//         // .data[payMobToken]
//       },
//       onError: (error) {
//         dismissLoading();
//       },
//     );
//     return response;
//   }

//   Future<int> _orderRegitstartionApi({
//     required String authanticationToken,
//     required String amount,
//     required String currency,
//   }) async {
//     startLoading();
//     int response = 1;
//     ApiRequest(
//       // path: authontication,
//       className: '',
//       formatResponse: true,
//       method: ApiMethods.post,
//       body: {
//         "auth_token": authanticationToken,
//         "amount_cents": amount,
//         "delivery_needed": currency,
//         "items": [],
//       },
//     ).request(
//       onSuccess: (dynamic data, dynamic response) {
//         var dataResponse = List<Map<String, dynamic>>.from(data);
//         dismissLoading();
//         response = dataResponse;
//         // .data[idPaymob]
//       },
//       onError: (error) {
//         dismissLoading();
//       },
//     );
//     return response;
//   }

//   Future _getpenyKey() async {
//     startLoading();
//     int response = 1;
//     ApiRequest(
//       // path: authontication,
//       className: '',
//       formatResponse: true,
//       method: ApiMethods.post,
//       body: {
//         // create aonly somethings and response token to create method payment
//       },
//     ).request(
//       onSuccess: (dynamic data, dynamic response) {
//         var dataResponse = List<Map<String, dynamic>>.from(data);
//         dismissLoading();
//         response = dataResponse;
//         // .data[payMobToken]
//       },
//       onError: (error) {
//         dismissLoading();
//       },
//     );
//     return response;
//   }
// }
