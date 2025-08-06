import 'package:dio/dio.dart';
import '../general_exports.dart';

class ApiRequest {
  ApiRequest({
    required this.className,
    this.path,
    this.fullUrl,
    this.method = ApiMethods.get,
    this.header,
    this.body,
    this.queryParameters,
    this.formatResponse = false,
    this.withLoading = false,
    this.shouldRemoveBidderIdFromDefaultQuery = false,
    this.shouldShowMessage = true,
    this.shouldShowRequestDetails = true,
  });

  final MyAppController myAppController = Get.find<MyAppController>();
  final String? path;
  final String? fullUrl;
  final ApiMethods method;
  final String? className;
  final Map<String, dynamic>? header;
  final bool withLoading;
  final bool formatResponse;
  final bool shouldShowMessage;
  final bool shouldShowRequestDetails;
  final bool shouldRemoveBidderIdFromDefaultQuery;
  final dynamic body;
  final dynamic queryParameters;
  dynamic response;

  Future<Dio> _dio() async {
    final Map<String, dynamic> defaultQueryParams =
        await getDefaultQueryParams();
    if (shouldRemoveBidderIdFromDefaultQuery) {
      defaultQueryParams.remove(keyName);
    }
    return Dio(
      BaseOptions(
        headers: <String, dynamic>{
          'Content-Type': '*/*',
          'Accept': '*/*',
          //  'sharedKey': sharedKey,
          ...(header ?? <String, dynamic>{}),
        },
        // queryParameters: <String, dynamic>{
        //   ...defaultQueryParams,
        //   ...queryParameters ?? <String, dynamic>{},
        // },
      ),
    );
  }

  Future<void> request({
    Function()? beforeSend,
    Function(dynamic data, dynamic response)? onSuccess,
    Function(dynamic data, dynamic response, dynamic header)?
    onSuccessWithHeader,
    Function(dynamic error)? onError,
  }) async {
    // start request time
    final DateTime startTime = DateTime.now();

    final Dio dio = await _dio();

    try {
      if (withLoading) {
        startLoading();
      }
      switch (method) {
        case ApiMethods.get:
          response = await dio.get(fullUrl ?? (baseUrl + path!));
          break;
        case ApiMethods.post:
          response = await dio.post(fullUrl ?? (baseUrl + path!), data: body);
          break;
        case ApiMethods.put:
          response = await dio.put(fullUrl ?? (baseUrl + path!), data: body);
          break;
        case ApiMethods.delete:
          response = await dio.delete(fullUrl ?? (baseUrl + path!), data: body);
          break;
        case ApiMethods.patch:
          response = await dio.patch(
            fullUrl ?? (baseUrl + path!),
            data: body,
            queryParameters: queryParameters,
          );
          break;
      }
      // print response data in console
      if (shouldShowRequestDetails) {
        showRequestDetails(
          method: method.toString(),
          path: path,
          fullUrl: fullUrl,
          formatResponse: formatResponse,
          className: className,
          body: body.toString(),
          headers: dio.options.headers,
          queryParameters: dio.options.queryParameters.toString(),
          response: response.data,
        );
      }

      if (withLoading) {
        dismissLoading();
      }

      if (onSuccess != null) {
        onSuccess(response.data, response.data);
      }
      if (onSuccessWithHeader != null) {
        onSuccessWithHeader(response.data, response.data, response.headers.map);
      }
    } on Exception catch (error) {
      dismissLoading();
      // request time
      final int time = DateTime.now().difference(startTime).inMilliseconds;

      if (error is DioException) {
        final dynamic errorData =
            error.response?.data ??
            <String, dynamic>{
              'errors': <Map<String, String>>[
                <String, String>{'message': error.toString()},
              ],
            };
        // print response error
        if (shouldShowRequestDetails) {
          showRequestDetails(
            method: method.toString(),
            path: path,
            fullUrl: fullUrl,
            formatResponse: formatResponse,
            className: className,
            body: body.toString(),
            headers: dio.options.headers,
            queryParameters: dio.options.queryParameters.toString(),
            response: errorData,
            time: time,
            isError: true,
          );
        }
        if (shouldShowMessage) {
          showMessage(
            description:
                errorData['errors'] != null && errorData['errors'].length > 0
                ? errorData['errors'][0]['message']
                : errorData['message'],
          );
        }
      } else {
        if (shouldShowRequestDetails) {
          showRequestDetails(
            method: method.toString(),
            path: path,
            fullUrl: fullUrl ?? (baseUrl + path!),
            formatResponse: formatResponse,
            className: className,
            body: body.toString(),
            headers: dio.options.headers,
            queryParameters: dio.options.queryParameters.toString(),
            response: error,
            time: time,
            isError: true,
            otherCatch: true,
          );
        }
      }
    }
  }

  void signOutUserAbdOpenSignInSheet() {
    myAppController.onSignOut();
    // Navigator.popUntil(
    //   Get.context!,
    //   (dynamic r) => r.settings.name == routeHomeBottomBar,
    // );
    // myAppController.openSignInSheet(
    //   action: () {
    //     Get.find<HomeBottomBarController>().onItemTapped(0);
    //     Get.find<HomeBottomBarController>().update();
    //   },
    // );
  }
}

enum ApiMethods { get, post, put, delete, patch }
