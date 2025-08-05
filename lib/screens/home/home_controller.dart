import '../../general_exports.dart';

class HomeController extends GetxController {
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
      path: users,
      className: 'HomeController',
      formatResponse: true,
    ).request(
      onSuccess: (dynamic data, dynamic response) {
        dismissLoading();
        this.response = data;
        auctionMaster = this.response;
        setCurrentAuctions();
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
    if (selectedAuctionStatus != null) {
      currentAuctions.addAll(
        auctionMaster.where(
          (element) => element[name] == selectedAuctionStatus[name],
        ),
      );
    } else {
      currentAuctions.addAll(auctionMaster);
    }
    update();
  }
}
