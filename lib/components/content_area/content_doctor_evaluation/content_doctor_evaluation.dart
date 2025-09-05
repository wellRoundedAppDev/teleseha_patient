import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../general_exports.dart';

class ContentDoctorEvaluation extends StatelessWidget {
  ContentDoctorEvaluation({super.key});
  
  final ChangeParamContentAndNextPage change = Get.find();
  BookingsController bookings = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      builder: (DoctorsController controller) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: DEVICE_HEIGHT * 0.03),
                    Column(
                      children: <Widget>[
                        Image.asset(
                          bookings.selectedLastRecent?['image'],
                          width: 81,
                          height: 87,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.012),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SvgPicture.asset(
                              iconDoctors,
                              width: DEVICE_WIDTH * 0.047,
                              height: DEVICE_WIDTH * 0.047,
                              // ignore: deprecated_member_use
                              color: const Color(AppColors.colorLineAndText),
                            ),
                            SizedBox(width: DEVICE_WIDTH * 0.012),
                            CustomText(
                              text: bookings.selectedLastRecent?['name']
                                  .toString()
                                  .tr,
                              fontSize: 18,
                              type: CustomTextType.title,
                              color: const Color(AppColors.colorLineAndText),
                            ),
                          ],
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.007),
                        CustomText(
                          text: bookings.selectedLastRecent?['specialization']
                              .toString()
                              .tr,
                          fontSize: 12,
                          type: CustomTextType.inputTitle,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                        SizedBox(height: DEVICE_HEIGHT * 0.007),
                        CustomText(
                          text: 'active_now'.tr,
                          fontSize: 12,
                          type: CustomTextType.title,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                      ],
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.015),
                    SizedBox(
                      width: DEVICE_WIDTH * 0.8,
                      child: CustomText(
                        text:
                            "${'evaluate_your_session'.tr} ${bookings.selectedLastRecent?['name'].toString().tr} ${'to_help'.tr}",
                        fontSize: 14,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorLineAndText),
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.015),
                    Center(
                      child: RatingBar.builder(
                        minRating: 1,
                        allowHalfRating: true,
                        itemPadding: const EdgeInsets.symmetric(
                          horizontal: 1.5,
                        ),
                        unratedColor: const Color(AppColors.colorWhite),
                        itemBuilder: (BuildContext context, _) => const Icon(
                          Icons.star,
                          color: Color(AppColors.colorGoldRainsStar),
                        ),
                        onRatingUpdate: (double rating) {
                          consoleLog(rating);
                        },
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.04),
                    Wrap(
                      spacing: 18,
                      runSpacing: 8.0,
                      // ignore: always_specify_types
                      children: List.generate(controller.ratings.length, (
                        int index,
                      ) {
                        // ignore: always_specify_types
                        final rating = controller.ratings[index];
                        final bool isSelected =
                            controller.selectedRatingIndex.value == index;
                        return GestureDetector(
                          onTap: () {
                            controller.selectedRatingIndex.value = index;
                            controller.update();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: DEVICE_WIDTH * 0.260,
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: const Color(
                                    0xFFD8DADC,
                                  ).withValues(alpha: 0.8),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              color: isSelected
                                  ? const Color(AppColors.colorLineAndText)
                                  : const Color(
                                      AppColors.colorWhiteSelectedType,
                                    ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CustomText(
                                  text:
                                      rating['titleRatings'] ??
                                      'good_listen'.tr,
                                  fontSize: 10,
                                  type: CustomTextType.title,
                                  color: isSelected
                                      ? const Color(
                                          AppColors.colorWhiteSelectedType,
                                        )
                                      : const Color(AppColors.colorLineAndText),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  rating['icon'] ?? iconGoodListen,
                                  width: 30,
                                  height: 30,
                                  // ignore: deprecated_member_use
                                  color: isSelected
                                      ? const Color(
                                          AppColors.colorWhiteSelectedType,
                                        )
                                      : const Color(AppColors.colorGoldRains),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.043),
                    CustomText(
                      text: 'what_is_your_comment_on_the_session'.tr,
                      fontSize: 15,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorLineAndText),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.012),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: DEVICE_WIDTH * 0.05,
                      ),
                      width: DEVICE_WIDTH,
                      height: DEVICE_HEIGHT * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(AppColors.colorWhite),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.005),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: controller.yourCommentOnTheSession,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'write_your_comment_about_the_session'.tr,
                            hintStyle: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: const Color(
                                AppColors.colorHintText,
                              ).withValues(alpha: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                    CustomText(
                      text: 'enough_consultation_time'.tr,
                      fontSize: 14,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorLineAndText),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.012),
                    Center(
                      child: RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        allowHalfRating: true,
                        itemPadding: const EdgeInsets.symmetric(
                          horizontal: 1.5,
                        ),
                        unratedColor: const Color(AppColors.colorWhite),
                        itemBuilder: (BuildContext context, _) => const Icon(
                          Icons.star,
                          color: Color(AppColors.colorGoldRainsStar),
                        ),
                        onRatingUpdate: (double rating) {
                          consoleLog(rating);
                        },
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.045),
                    Container(
                      margin: const EdgeInsets.only(bottom: 66),
                      child: Align(
                        child: Btn(
                          onPressed: () {
                            change.goToComponentHeader.value =
                                'ContentPrescription';
                          },
                          text: 'send_evaluation'.tr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isSelected == 1)
                SizedBox(height: DEVICE_HEIGHT * 0.12)
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
