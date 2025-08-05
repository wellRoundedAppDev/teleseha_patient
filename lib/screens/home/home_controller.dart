import '../../general_exports.dart';

class HomeController extends GetxController {
  List<dynamic> auctionStatuses =
      Get.find<MyAppController>().lovData[name][name];
  dynamic selectedAuctionStatus;
  List<dynamic> currentAuctions = <dynamic>[];
  List<dynamic> auctionMaster = <dynamic>[];
  bool isLoading = true;

  dynamic response;
  @override
  void onReady() {
    super.onReady();
    getHomeData();
  }

  void getHomeData() {
    startLoading();
    ApiRequest(
      path: general,
      className: 'HomeController',
      formatResponse: true,
      queryParameters: <String, String>{
        name: Get.find<MyAppController>().appLocale,
      },
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();

        this.response = data;
        auctionMaster = data[name];
        selectedAuctionStatus = auctionStatuses
            .where((dynamic element) => element[name] == data[name])
            .first;
        setCurrentAuctions();
        filterMapData = data[name];
        isLoading = false;

        update();
      },
    );
  }

  void onSelectedAuctionStatus(dynamic status) {
    selectedAuctionStatus = status;
    setCurrentAuctions();
  }

  void setCurrentAuctions() {
    currentAuctions.clear();
    currentAuctions.addAll(
      auctionMaster.where(
        (dynamic element) => element[name] == selectedAuctionStatus[name],
      ),
    );
    update();
  }
}
