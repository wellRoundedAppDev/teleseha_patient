import '../../general_exports.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.grey),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (HomeController controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: DEVICE_HEIGHT * 0.06,
              left: DEVICE_WIDTH * 0.02,
              right: DEVICE_WIDTH * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                Text('home'.tr),
                SizedBox(height: DEVICE_HEIGHT * 0.02),
                Row(
                  children: <Widget>[
                    ...controller.auctionStatuses.map(
                      (e) => Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              controller.onSelectedAuctionStatus(e);
                            },
                            child: RoundedContainer(
                              color: controller.selectedAuctionStatus == e
                                  ? const Color(AppColors.grey)
                                  : const Color(AppColors.transparent),
                              borderColor: AppColors.grey,
                              borderWidth: 1,
                              child: Center(
                                child: Text(
                                  e[name],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: controller
                                                    .selectedAuctionStatus ==
                                                e
                                            ? const Color(AppColors.grey)
                                            : const Color(AppColors.grey),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: DEVICE_WIDTH * 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
                if (controller.isLoading)
                  const Center()
                else
                  controller.currentAuctions.isEmpty
                      ? SizedBox(
                          height: DEVICE_HEIGHT * 0.6,
                          child: Align(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: DEVICE_HEIGHT * 0.03,
                                ),
                                Text(
                                  'no_auctions'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: const Color(
                                          AppColors.grey,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: DEVICE_HEIGHT * 0.02,
                          ),
                          child: Column(
                            children: <Widget>[
                              ...controller.currentAuctions.map(
                                (dynamic e) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: DEVICE_WIDTH * 0.03,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        routeSplash,
                                        arguments: <String, dynamic>{
                                          'item': e,
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
              ],
            ),
          );
        },
      ),
    );
  }
}
