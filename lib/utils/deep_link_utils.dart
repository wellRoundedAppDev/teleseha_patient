import 'dart:async';

import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../general_exports.dart';

StreamSubscription<Map<dynamic, dynamic>>? streamSubscription;
// StreamController<String> controllerData = StreamController<String>();
// BranchContentMetaData metadata = BranchContentMetaData();

Future<void> listenDynamicLinks() async {
  streamSubscription = FlutterBranchSdk.listSession().listen(
    (Map<dynamic, dynamic> data) async {
      consoleLog('listenDynamicLinks - DeepLink Data: $data');
      redirectDeepLink(data);
      // controllerData.sink.add((data.toString()));

      /*
      if (data.containsKey('+is_first_session') &&
          data['+is_first_session'] == true) {
        // wait 3 seconds to obtain installation data
        await Future.delayed(const Duration(seconds: 3));
        Map<dynamic, dynamic> params =
            await FlutterBranchSdk.getFirstReferringParams();
        controllerData.sink.add(params.toString());
        return;
      }
       

    if (data.containsKey('+clicked_branch_link') &&
        data['+clicked_branch_link'] == true) {
      consoleLog(
          '------------------------------------Link clicked----------------------------------------------');
      consoleLog('Title: ${data[r'$og_title']}');
      consoleLog('Custom string: ${data['custom_string']}');
      consoleLog('Custom number: ${data['custom_number']}');
      consoleLog('Custom bool: ${data['custom_bool']}');
      consoleLog('Custom date: ${data['custom_date_created']}');
      consoleLog('Custom list number: ${data['custom_list_number']}');
      consoleLog(
          '------------------------------------------------------------------------------------------------');
      consoleLog(
        'Link clicked: Custom string - ${data['custom_string']} - Date: ${data['custom_date_created'] ?? ''}',
      );
    }
    */
    },
    onError: (dynamic error) {
      consoleLog('listSession error: ${error.toString()}');
    },
  );
}

void redirectDeepLink(Map<dynamic, dynamic> data) {
  consoleLog(data, key: 'deep_link_data');
  final String id = data[keyId]?.toString() ?? '';
  final String page = data[keyScreenName]?.toString() ?? '';
  consoleLog(page, key: 'page');
  consoleLog(id, key: keyId);
  if (page == 'auction_item_detail') {
    Get.toNamed(
      routeAuctionItemDetails,
      arguments: <String, dynamic>{'auctionItemId': int.parse(id)},
    );
  } else if (page == 'my_auctions') {
    if (Get.find<MyAppController>().userData != null) {
      Get.offAllNamed(routeHomeBottomBar);
      Get.find<HomeBottomBarController>().onItemTapped(2);
    }
  }
}
