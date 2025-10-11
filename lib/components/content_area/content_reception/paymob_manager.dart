import '../../../general_exports.dart';

class PayMobManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    final String authanticationRequest = await _getAuthanticatToken();
    await _orderRegitstartionApi(
      amount: (100 * amount).toString(),
      authanticationToken: authanticationRequest,
      currency: currency,
    );
    final String paymentKey = await _getpenyKey();
    return paymentKey;
  }

  Future<String> _getAuthanticatToken() async {
    startLoading();
    final String response = '';
    ApiRequest(
      // path: authontication,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <String, String>{'api_key': 'apiKey'},
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        final List<Map<String, dynamic>> dataResponse =
            List<Map<String, dynamic>>.from(data);
        dismissLoading();
        response = dataResponse;
        // .data[payMobToken]
      },
      // ignore: always_specify_types
      onError: (error) {
        dismissLoading();
        return null;
      },
    );
    return response;
  }

  Future<int> _orderRegitstartionApi({
    required String authanticationToken,
    required String amount,
    required String currency,
  }) async {
    startLoading();
    final int response = 1;
    ApiRequest(
      // path: authontication,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: {
        'auth_token': authanticationToken,
        'amount_cents': amount,
        'delivery_needed': currency,
        'items': <dynamic>[],
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        final List<Map<String, dynamic>> dataResponse =
            List<Map<String, dynamic>>.from(data);
        dismissLoading();
        response = dataResponse;
        // .data[idPaymob]
      },
      // ignore: always_specify_types
      onError: (error) {
        dismissLoading();
        return null;
      },
    );
    return response;
  }

  // ignore: always_specify_types
  Future _getpenyKey() async {
    startLoading();
    final int response = 1;
    ApiRequest(
      // path: authontication,
      className: '',
      formatResponse: true,
      method: ApiMethods.post,
      body: <dynamic, dynamic>{
        // create aonly somethings and response token to create method payment
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        final List<Map<String, dynamic>> dataResponse =
            List<Map<String, dynamic>>.from(data);
        dismissLoading();
        response = dataResponse;
        // .data[payMobToken]
      },
      // ignore: always_specify_types
      onError: (error) {
        dismissLoading();
        return null;
      },
    );
    return response;
  }
}
