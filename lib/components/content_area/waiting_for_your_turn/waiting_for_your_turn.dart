import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class WaitingForYourTurn extends StatelessWidget {
  const WaitingForYourTurn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingsController>(
      builder: (BookingsController controller) {
        if (controller.currentStep == 2) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final VideoCallController videoCall = Get.find();
            if (!videoCall.isCallStarted.value) {
              videoCall.initAgora();
            }
          });
        }

        controller.selectedLastRecentFunction();
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: DEVICE_HEIGHT * 0.012,
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.orange,
                    child: GestureDetector(
                      onTap: () {
                        final VideoCallController videoCall =
                            Get.find<VideoCallController>();
                        videoCall.joinAsFirstUser();
                      },
                      child: const Text('Join as first participant'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    controller.selectedLastRecent?['image'],
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
                        text: controller.selectedLastRecent?['name'],
                        fontSize: 16,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorLineAndText),
                      ),
                    ],
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.007),
                  CustomText(
                    text: controller.selectedLastRecent?['specialization'],
                    fontSize: 12,
                    type: CustomTextType.inputTitle,
                    color: const Color(AppColors.colorLineAndText),
                  ),
                  SizedBox(height: DEVICE_HEIGHT * 0.007),
                  Center(
                    child: RatingBar.builder(
                      itemSize: 17,
                      minRating: 3,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      initialRating: 3.5,
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
                  SizedBox(height: DEVICE_HEIGHT * 0.007),
                  CustomText(
                    text: 'active_now'.tr,
                    fontSize: 12,
                    type: CustomTextType.title,
                    color: const Color(AppColors.colorLineAndText),
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.03),
              CustomText(
                text: 'wait_your_turn'.tr,
                fontSize: 16,
                type: CustomTextType.title,
                color: const Color(AppColors.colorLineAndText),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: always_specify_types
                  children: List.generate(controller.totalSteps, (int index) {
                    final bool isActive = index == controller.currentStep;

                    final double circleSize = isActive ? 48 : 24;
                    final double iconSize = isActive ? 20 : 0;
                    return Row(
                      children: <Widget>[
                        Container(
                          width: circleSize,
                          height: circleSize,
                          padding: isActive
                              ? const EdgeInsets.all(3)
                              : EdgeInsets.zero,
                          decoration: isActive
                              ? BoxDecoration(
                                  color: const Color(
                                    AppColors.colorWhiteSelectedType,
                                  ),
                                  border: Border.all(
                                    width: 2,
                                    color: index == 2
                                        ? const Color(
                                            AppColors.colorSuccessLine,
                                          )
                                        : const Color(
                                            AppColors.colorLineAndText,
                                          ),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                )
                              : null,
                          child: CircleAvatar(
                            radius: iconSize,
                            backgroundColor: (isActive && index == 2)
                                ? const Color(AppColors.colorSuccessLine)
                                : const Color(AppColors.colorLineAndText),
                            child: Builder(
                              builder: (_) {
                                if (index == 0 &&
                                    index == controller.currentStep) {
                                  return SvgPicture.asset(
                                    iconDoctors,
                                    width: DEVICE_WIDTH * 0.022,
                                    height: DEVICE_HEIGHT * 0.022,
                                    // ignore: deprecated_member_use
                                    color: const Color(
                                      AppColors.colorWhiteSelectedType,
                                    ),
                                  );
                                } else if (index == 2) {
                                  return isActive &&
                                          index == controller.currentStep
                                      ? SvgPicture.asset(
                                          iconUserStepsGreen,
                                          width: DEVICE_WIDTH * 0.022,
                                          height: DEVICE_HEIGHT * 0.022,
                                          fit: BoxFit.cover,
                                        )
                                      : SvgPicture.asset(
                                          iconUserSteps,
                                          width: DEVICE_WIDTH * 0.022,
                                          height: DEVICE_HEIGHT * 0.022,
                                          fit: BoxFit.cover,
                                        );
                                } else if (index == controller.currentStep) {
                                  return const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ),
                        if (index < controller.totalSteps - 1)
                          Container(
                            width: DEVICE_WIDTH * 0.11,
                            height: 4,
                            color: const Color(AppColors.colorLineAndText),
                          ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              if (controller.currentStep == 0)
                CustomText(
                  text: 'there_is_one_person_in_front_of_you'.tr,
                  fontSize: 11,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorTextSkep),
                )
              else
                CustomText(
                  text: 'its_your_turn'.tr,
                  fontSize: 11,
                  type: CustomTextType.title,
                  color: const Color(AppColors.colorLineAndText),
                ),
              if (controller.currentStep == 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: DEVICE_HEIGHT * 0.055),
                    Row(
                      children: <Widget>[
                        CustomText(
                          text: 'your_expected_entry_time'.tr,
                          fontSize: 12,
                          type: CustomTextType.title,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                        CustomText(
                          text:
                              '${'remain'.tr} ${controller.remainingMinutes} ${'minute'.tr}',
                          fontSize: 12,
                          type: CustomTextType.title,
                          color: const Color(AppColors.colorLineAndText),
                        ),
                      ],
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.008),
                    CustomText(
                      text: 'dont_worry'.tr,
                      fontSize: 9,
                      type: CustomTextType.title,
                      color: const Color(AppColors.colorTextSkep),
                    ),
                  ],
                )
              else
                const SizedBox(),
              SizedBox(height: DEVICE_HEIGHT * 0.07),
              GetBuilder<VideoCallController>(
                id: 'participantButton',
                builder: (VideoCallController videoCall) {
                  final bool hasParticipant = videoCall.hasParticipant;
                  return Btn(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hasParticipant
                          ? const Color(AppColors.colorLineAndText)
                          : const Color.fromRGBO(0, 123, 189, 0.49),
                      padding: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.02,
                      ),
                    ),
                    onPressed: hasParticipant
                        ? () async {
                            Get.toNamed(routeVideoCall);
                          }
                        : null,
                    text: hasParticipant ? 'enter_the_session'.tr : 'wait'.tr,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
