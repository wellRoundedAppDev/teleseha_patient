// import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class RecentBookings extends StatelessWidget {
  const RecentBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingsController>(
      init: BookingsController(),
      builder: (BookingsController controller) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: DEVICE_HEIGHT * 0.015,
            vertical: DEVICE_WIDTH * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  final ChangeParamContentAndNextPage change = Get.find();
                  change.goToComponentHeader.value = 'waitingForYourTurn';
                  change.update();
                },
                child: const Text('test'),
              ),
              CustomText(
                text: 'Recent_bookings'.tr,
                fontSize: 18,
                type: CustomTextType.title,
                color: const Color(AppColors.colorLineAndText),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              // SizedBox(
              //   height: DEVICE_HEIGHT * 0.536,
              //   child: controller.isLoading
              //       ? const Center(child: CircularProgressIndicator())
              //       : controller.lastRecent.isEmpty
              //       ? Center(
              //           child: CustomText(
              //             text: 'recent_bookings_not_found'.tr,
              //             type: CustomTextType.title,
              //             fontSize: 13,
              //             color: const Color(AppColors.colorTitle),
              //           ),
              //         )
              //       : ListView.builder(
              //           itemCount: controller.lastRecent.length,
              //           shrinkWrap: true,
              //           padding: EdgeInsets.zero,
              //           itemBuilder: (BuildContext context, int index) {
              //             return Container(
              //               margin: EdgeInsets.only(
              //                 bottom: DEVICE_HEIGHT * 0.022,
              //               ),
              //               padding: const EdgeInsets.all(20.0),
              //               decoration: BoxDecoration(
              //                 boxShadow: <BoxShadow>[
              //                   BoxShadow(
              //                     color: const Color(
              //                       0xFFD8DADC,
              //                     ).withValues(alpha: 0.4),
              //                     blurRadius: 6,
              //                     spreadRadius: 2,
              //                     offset: const Offset(0, 2),
              //                   ),
              //                 ],
              //                 color: const Color(AppColors.colorLastReception),
              //                 borderRadius: BorderRadius.circular(16),
              //               ),
              //               child: Column(
              //                 children: <Widget>[
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: <Widget>[
              //                       Row(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: <Widget>[
              //                           ClipRRect(
              //                             borderRadius:
              //                                 BorderRadiusGeometry.circular(10),
              //                             child: Image.asset(
              //                               controller
              //                                   .lastRecent[index]['image'],
              //                               width: DEVICE_WIDTH * 0.17,
              //                               height: DEVICE_HEIGHT * 0.083,
              //                               fit: BoxFit.cover,
              //                             ),
              //                           ),
              //                           SizedBox(width: DEVICE_WIDTH * 0.02),
              //                           Container(
              //                             margin: const EdgeInsets.only(top: 3),
              //                             child: Column(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: <Widget>[
              //                                 SizedBox(
              //                                   child: Row(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment
              //                                             .spaceBetween,
              //                                     children: <Widget>[
              //                                       CustomText(
              //                                         text: controller
              //                                             .lastRecent[index]['name']
              //                                             .toString()
              //                                             .tr,
              //                                         type:
              //                                             CustomTextType.title,
              //                                         fontSize: 14,
              //                                         color: const Color(
              //                                           AppColors
              //                                               .colorLineAndText,
              //                                         ),
              //                                       ),
              //                                     ],
              //                                   ),
              //                                 ),
              //                                 SizedBox(
              //                                   height: DEVICE_HEIGHT * 0.004,
              //                                 ),
              //                                 Row(
              //                                   children: <Widget>[
              //                                     CustomText(
              //                                       text: controller
              //                                           .lastRecent[index]['specialization']
              //                                           .toString()
              //                                           .tr,
              //                                       type: CustomTextType
              //                                           .inputTitle,
              //                                       fontSize: 12,
              //                                       color: const Color(
              //                                         AppColors
              //                                             .colorLineAndText,
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       Row(
              //                         children: <Widget>[
              //                           const CustomText(
              //                             text: '4.9',
              //                             fontSize: 10,
              //                             type: CustomTextType.title,
              //                             color: Color(
              //                               AppColors.colorLineAndText,
              //                             ),
              //                           ),
              //                           SizedBox(width: DEVICE_WIDTH * 0.012),
              //                           SvgPicture.asset(
              //                             iconStar,
              //                             width: DEVICE_WIDTH * 0.025,
              //                             height: DEVICE_HEIGHT * 0.015,
              //                           ),
              //                           SizedBox(width: DEVICE_WIDTH * 0.025),
              //                           CustomText(
              //                             text: 'detection_times'.tr,
              //                             fontSize: 10,
              //                             type: CustomTextType.inputTitle,
              //                             color: const Color(
              //                               AppColors.colorLineAndText,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(height: DEVICE_HEIGHT * 0.02),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: <Widget>[
              //                       Row(
              //                         children: <Widget>[
              //                           Row(
              //                             children: <Widget>[
              //                               SvgPicture.asset(
              //                                 iconCalendar,
              //                                 width: DEVICE_WIDTH * 0.025,
              //                                 height: DEVICE_HEIGHT * 0.015,
              //                               ),
              //                               SizedBox(
              //                                 width: DEVICE_WIDTH * 0.017,
              //                               ),
              //                               CustomText(
              //                                 text: 'accosts'.tr,
              //                                 fontSize: 12,
              //                                 type: CustomTextType.title,
              //                                 color: const Color(
              //                                   AppColors.colorLineAndText,
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                           SizedBox(width: DEVICE_WIDTH * 0.033),
              //                           Container(
              //                             margin: const EdgeInsets.only(top: 2),
              //                             child: Row(
              //                               children: <Widget>[
              //                                 CustomText(
              //                                   text: '2:00'.tr,
              //                                   fontSize: 12,
              //                                   type: CustomTextType.title,
              //                                   color: const Color(
              //                                     AppColors.colorLineAndText,
              //                                   ),
              //                                 ),
              //                                 SizedBox(
              //                                   width: DEVICE_WIDTH * 0.017,
              //                                 ),
              //                                 SvgPicture.asset(
              //                                   iconTime,
              //                                   width: DEVICE_WIDTH * 0.025,
              //                                   height: DEVICE_HEIGHT * 0.015,
              //                                   // ignore: deprecated_member_use
              //                                   color: const Color(
              //                                     AppColors.colorLineAndText,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       StyleBtnHeader(
              //                         textBtn: 'entry_to_the_session'.tr,
              //                         onPressed: () {
              //                           final int lastRecentId =
              //                               controller.lastRecent[index]['id'];
              //                           controller.passedIndex = lastRecentId;

              //                           final ChangeParamContentAndNextPage
              //                           change = Get.find();
              //                           change.goToComponentHeader.value =
              //                               'waitingForYourTurn';
              //                           change.update();

              //                           // import 'paymob_manager.dart';
              //                           // import 'package:url_launcher/url_launcher.dart';

              //                           // Future<void> _pay() async {
              //                           //   PayMobManager().getPaymentKey(10, 'EGP').then((String paymentKey) {
              //                           //     launchUrl(
              //                           //       Uri.parse(
              //                           //         "https://accept.paymob.com/api/acceptance/iframe/5555/?payment_token${paymentKey}",
              //                           //       ),
              //                           //     );
              //                           //   });
              //                           // }
              //                         },
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
