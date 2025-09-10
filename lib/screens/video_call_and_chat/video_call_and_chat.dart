import 'dart:io';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class VideoCall extends StatelessWidget {
  VideoCall({super.key});
  final ChangeParamContentAndNextPage change = Get.find();
  final BookingsController bookings = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      builder: (VideoCallController controller) {
        bookings.selectedLastRecentFunction();

        final String minutes = (controller.secondsLeft ~/ 60)
            .toString()
            .padLeft(2, '0');
        final String seconds = (controller.secondsLeft % 60).toString().padLeft(
          2,
          '0',
        );
        Widget localVideoWidget() {
          if (controller.localUserJoined) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: DEVICE_HEIGHT,
              child: controller.isVideoMuted
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(18),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromRGBO(128, 128, 128, 0.40),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(18),
                        child: Image.asset(
                          imageUnsplash,
                          // bookings.selectedLastRecent?['image'],
                          fit: BoxFit.cover,
                        ),
                        // imageUnsplash,
                      ),
                    )
                  : AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: controller.engine,
                        canvas: const VideoCanvas(
                          uid: 0,
                          renderMode: RenderModeType.renderModeHidden,
                        ),
                      ),
                    ),
            );
          } else {
            if (controller.isCallEnded.value) {
              return Image.asset(
                imageCallPatient,
                fit: BoxFit.cover,
                width: DEVICE_WIDTH,
                height: DEVICE_HEIGHT,
              );
            } else {
              return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
            }
          }
        }

        Widget remoteVideoWidget() {
          if (controller.isCallEnded.value) {
            return Image.asset(
              // imageUnsplash,
              bookings.selectedLastRecent?['image'],
              fit: BoxFit.cover,
              width: DEVICE_WIDTH,
              height: DEVICE_HEIGHT,
            );
          } else {
            if (controller.remoteUid == null || controller.remoteUid == 0) {
              return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
            }
          }
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(128, 128, 128, 0.40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child:
                  controller.isRemoteVideoMuted || controller.isCallEnded.value
                  ? Image.asset(
                      bookings.selectedLastRecent?['image'],
                      fit: BoxFit.cover,
                    )
                  // imageUnsplash
                  : AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: controller.engine,
                        canvas: VideoCanvas(uid: controller.remoteUid),
                        connection: RtcConnection(
                          channelId: controller.channel,
                        ),
                      ),
                    ),
            ),
          );
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: DEVICE_HEIGHT,
                child: controller.isSwapped
                    ? remoteVideoWidget()
                    : localVideoWidget(),
              ),
              Container(
                margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
                padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(),
                    Container(
                      margin: EdgeInsets.only(right: DEVICE_WIDTH * 0.14),
                      child: CustomText(
                        text: '[$minutes:$seconds]',
                        fontSize: 24,
                        type: CustomTextType.title,
                        color: const Color(AppColors.colorWhiteSelectedType),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: DEVICE_HEIGHT * 0.09,
                right: DEVICE_WIDTH * 0.05,
                child: SizedBox(
                  width: DEVICE_WIDTH * 0.25,
                  height: DEVICE_HEIGHT * 0.17,
                  child: controller.isSwapped
                      ? localVideoWidget()
                      : remoteVideoWidget(),
                ),
              ),
              Positioned(
                top: DEVICE_HEIGHT * 0.24,
                right: DEVICE_WIDTH * 0.135,
                child: GestureDetector(
                  onTap: () {
                    controller.swapVideoPosition();
                  },
                  child: SvgPicture.asset(
                    iconRotation,
                    width: DEVICE_WIDTH * 0.04,
                    height: DEVICE_HEIGHT * 0.04,
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  DraggableScrollableSheet(
                    controller: controller.bottomSheetController,
                    initialChildSize: 220 / MediaQuery.of(context).size.height,
                    minChildSize: 0.15,
                    maxChildSize: 0.9,
                    builder:
                        (
                          BuildContext context,
                          ScrollController scrollController,
                        ) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Color(AppColors.colorWhiteSelectedType),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child:
                                NotificationListener<
                                  DraggableScrollableNotification
                                >(
                                  onNotification:
                                      (
                                        DraggableScrollableNotification
                                        notification,
                                      ) {
                                        controller
                                                .bottomSheetSizePageChat
                                                .value =
                                            notification.extent;

                                        if (notification.extent > 0.7 &&
                                            !controller
                                                .hasNavigatedToDoctorInfo) {
                                          controller.hasNavigatedToDoctorInfo =
                                              true;
                                          controller.isShowTextfield = false;
                                          controller.update();
                                        } else if (notification.extent <= 0.7 &&
                                            controller
                                                .hasNavigatedToDoctorInfo) {
                                          controller.hasNavigatedToDoctorInfo =
                                              false;
                                          controller.isShowTextfield = true;
                                          controller.update();
                                        }

                                        return true;
                                      },
                                  child: _defaultPageWidget(scrollController),
                                ),
                          );
                        },
                  ),
                  if (controller.isRotateFolderAndImageSend)
                    Obx(() {
                      final double sheetSize = controller.bottomSheetSize.value;
                      final double bottomOffset = sheetSize * DEVICE_HEIGHT;
                      return Positioned(
                        bottom: controller.isShowTextfield
                            ? bottomOffset - 55
                            : bottomOffset - 390,
                        left: DEVICE_WIDTH * 0.075,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: DEVICE_HEIGHT * 0.025,
                                vertical: DEVICE_WIDTH * 0.038,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  AppColors.colorBackgroundSendImages,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => controller.pickMedia(
                                      sourceType: 'file',
                                    ),
                                    child: SvgPicture.asset(
                                      iconFolder,
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => controller.pickMedia(
                                      sourceType: 'image',
                                    ),
                                    child: SvgPicture.asset(
                                      iconStudio,
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomPaint(
                                size: const Size(20, 10),
                                painter: _BubbleArrowPainter(
                                  color: const Color(
                                    AppColors.colorBackgroundSendImages,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  else
                    const SizedBox(),
                ],
              ),
              Obx(() {
                final double sheetSize = controller.bottomSheetSize.value;
                final double bottomOffset = sheetSize * DEVICE_HEIGHT;
                return Positioned(
                  bottom: bottomOffset + 4,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: DEVICE_WIDTH,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildActionButton(
                          icon: iconVideo,
                          onPressed: controller.toggleVideoMute,
                          isActive: !controller.isVideoMuted,
                        ),
                        _buildActionButton(
                          icon: iconPhone,
                          onPressed: () async {
                            await controller.endCall();
                          },
                          isActive: true,
                          isReversed: true,
                        ),
                        _buildActionButton(
                          icon: iconVoice,
                          onPressed: controller.toggleMute,
                          isActive: !controller.isMute,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Obx(() {
                if (controller.isCallEnded.value) {
                  return Container(
                    width: DEVICE_WIDTH,
                    height: DEVICE_HEIGHT,
                    color: const Color(AppColors.colorEndChat).withAlpha(153),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: 'thank_you_successfully_ended'.tr,
                          fontSize: 20,
                          type: CustomTextType.title,
                          color: const Color(AppColors.colorWhiteSelectedType),
                        ),
                        const SizedBox(height: 70),
                        Btn(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              AppColors.colorWhiteSelectedType,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: DEVICE_HEIGHT * 0.02,
                            ),
                          ),
                          colorText: const Color(AppColors.colorLineAndText),
                          onPressed: () {
                            change.goToComponentHeader.value =
                                'DoctorEvaluation';
                            Get.toNamed(routeScreen);
                          },
                          text: 'doctor_evaluation'.tr,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
              Positioned(
                top: DEVICE_HEIGHT * 0.09,
                left: DEVICE_WIDTH * 0.07,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    iconBack,
                    width: DEVICE_WIDTH * 0.04,
                    height: DEVICE_HEIGHT * 0.02,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _defaultPageWidget(ScrollController scrollController) {
  return GetBuilder<VideoCallController>(
    builder: (VideoCallController controller) {
      final Map<String, List<ChatLog>> logsGrouped = controller.groupLogsByDate(
        controller.logText,
      );
      final BookingsController bookings = Get.find();

      return Stack(
        children: <Widget>[
          ListView(
            controller: scrollController,
            children: <Widget>[
              Center(
                child: Container(
                  width: DEVICE_WIDTH * 0.24,
                  height: DEVICE_HEIGHT * 0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(AppColors.colorLineScrollBottomSheet),
                  ),
                ),
              ),
              if (!controller.isShowTextfield)
                SizedBox(height: DEVICE_HEIGHT * 0.05),
              if (!controller.isShowTextfield)
                ...logsGrouped.entries.map((
                  MapEntry<String, List<ChatLog>> entry,
                ) {
                  final String dateGroup = entry.key;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: CustomText(
                        text: dateGroup,
                        fontSize: 13,
                        type: CustomTextType.button,
                        color: const Color.fromRGBO(136, 136, 136, 0.83),
                      ),
                    ),
                  );
                }),
              if (controller.isShowTextfield)
                SizedBox(height: DEVICE_HEIGHT * 0.03),
              if (controller.isShowTextfield) _componentSend(),
              SizedBox(height: DEVICE_HEIGHT * 0.04),
              Container(
                height: DEVICE_HEIGHT * 0.6,
                padding: EdgeInsets.only(
                  bottom: 150,
                  right: DEVICE_WIDTH * 0.04,
                  left: DEVICE_WIDTH * 0.04,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: controller.logText.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ChatLog log = controller.logText[index];
                    return Align(
                      alignment: !log.isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.02),
                        width: DEVICE_WIDTH * 0.8,
                        child: Column(
                          crossAxisAlignment: log.isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: !log.isSentByMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: <Widget>[
                                if (!log.isSentByMe)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      imageCallPatient,
                                      width: DEVICE_WIDTH * 0.08,
                                      height: DEVICE_HEIGHT * 0.05,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                SizedBox(width: DEVICE_WIDTH * 0.01),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        if (!log.isSentByMe)
                                          BoxShadow(
                                            color: const Color(
                                              0xFFD8DADC,
                                            ).withValues(alpha: 0.4),
                                            blurRadius: 6,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                      ],
                                      color: log.isSentByMe
                                          ? const Color(
                                              AppColors.colorSendDoctor,
                                            )
                                          : const Color(
                                              AppColors.colorWhiteSelectedType,
                                            ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        if (log.message.isNotEmpty)
                                          CustomText(
                                            text: log.message,
                                            fontSize: 12,
                                            type: CustomTextType.title,
                                            color: log.isSentByMe
                                                ? const Color(
                                                    AppColors
                                                        .colorWhiteSelectedType,
                                                  )
                                                : const Color(
                                                    AppColors.colorLineAndText,
                                                  ),
                                          ),
                                        if (log.filePath != null &&
                                            log.filePath!.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child:
                                                _checkTypeFolderOrImageOrVideo(
                                                  log.filePath!,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: DEVICE_WIDTH * 0.02),
                                if (log.isSentByMe)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      imageUnsplash,
                                      // bookings.selectedLastRecent?['image'],
                                      width: DEVICE_WIDTH * 0.08,
                                      height: DEVICE_HEIGHT * 0.04,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: log.isSentByMe ? 5 : 17),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: log.isSentByMe ? 15 : 35,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    log.isDelivered
                                        ? Icons.done_all
                                        : Icons.done,
                                    size: 16,
                                    color: log.isDelivered
                                        ? Colors.blue
                                        : const Color(AppColors.colorGrey),
                                  ),
                                  SizedBox(width: DEVICE_WIDTH * 0.01),
                                  CustomText(
                                    text: controller.formatTimestamp(
                                      log.timestamp,
                                    ),
                                    fontSize: 13,
                                    type: CustomTextType.button,
                                    color: const Color(
                                      AppColors.colorInputConfirm,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // child: ListView.builder(
                //   itemCount: controller.logText.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     final ChatLog log = controller.logText[index];
                //     return Align(
                //       alignment: !log.isSentByMe
                //           ? Alignment.centerRight
                //           : Alignment.centerLeft,
                //       child: Container(
                //         margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.02),
                //         width: DEVICE_WIDTH * 0.8,
                //         child: Column(
                //           crossAxisAlignment: log.isSentByMe
                //               ? CrossAxisAlignment.end
                //               : CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               mainAxisAlignment: !log.isSentByMe
                //                   ? MainAxisAlignment.end
                //                   : MainAxisAlignment.start,
                //               children: <Widget>[
                //                 if (!log.isSentByMe)
                //                   ClipRRect(
                //                     borderRadius: BorderRadius.circular(30),
                //                     child: Image.asset(
                //                       imageUnsplash,
                //                       width: DEVICE_WIDTH * 0.09,
                //                       height: DEVICE_HEIGHT * 0.05,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 SizedBox(width: DEVICE_WIDTH * 0.01),
                //                 Expanded(
                //                   child: Container(
                //                     padding: const EdgeInsets.all(12),
                //                     decoration: BoxDecoration(
                //                       color: log.isSentByMe
                //                           ? const Color.fromARGB(
                //                               142,
                //                               75,
                //                               142,
                //                               178,
                //                             )
                //                           : const Color.fromARGB(
                //                               120,
                //                               180,
                //                               180,
                //                               180,
                //                             ),
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: <Widget>[
                //                         if (log.message.isNotEmpty)
                //                           CustomText(
                //                             text: log.message,
                //                             fontSize: 12,
                //                             type: CustomTextType.title,
                //                             color: const Color(
                //                               AppColors.colorWhiteSelectedType,
                //                             ),
                //                           ),
                //                         if (log.filePath != null &&
                //                             log.filePath!.isNotEmpty)
                //                           Padding(
                //                             padding: const EdgeInsets.only(
                //                               top: 8.0,
                //                             ),
                //                             child:
                //                                 _checkTypeFolderOrImageOrVideo(
                //                                   log.filePath!,
                //                                 ),
                //                           ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(width: DEVICE_WIDTH * 0.02),
                //                 if (log.isSentByMe)
                //                   ClipRRect(
                //                     borderRadius: BorderRadius.circular(30),
                //                     child: Image.asset(
                //                       imageCallPatient,
                //                       width: DEVICE_WIDTH * 0.09,
                //                       height: DEVICE_HEIGHT * 0.04,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //               ],
                //             ),
                //             const SizedBox(height: 4),
                //             Container(
                //               padding: EdgeInsets.symmetric(
                //                 horizontal: log.isSentByMe ? 25 : 35,
                //               ),
                //               child: Row(
                //                 children: <Widget>[
                //                   Icon(
                //                     log.isDelivered
                //                         ? Icons.done_all
                //                         : Icons.done,
                //                     size: 16,
                //                     color: log.isDelivered
                //                         ? const Color(AppColors.colorTextBlue)
                //                         : const Color(AppColors.colorGrey),
                //                   ),
                //                   SizedBox(width: DEVICE_WIDTH * 0.01),
                //                   CustomText(
                //                     text: controller.formatTimestamp(
                //                       log.timestamp,
                //                     ),
                //                     fontSize: 13,
                //                     type: CustomTextType.button,
                //                     color: const Color(
                //                       AppColors.colorInputConfirm,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          ),
          if (!controller.isShowTextfield)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Positioned(child: _componentSend()),
                ),
              ],
            ),
        ],
      );
    },
  );
}

Widget _buildActionButton({
  required String icon,
  required VoidCallback onPressed,
  required bool isActive,
  bool isReversed = false,
}) {
  final bool effectiveIsActive = isReversed ? !isActive : isActive;
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: FloatingActionButton(
        heroTag: icon,
        onPressed: onPressed,
        backgroundColor: effectiveIsActive
            ? const Color(AppColors.colorBackgroundIconCall)
            : const Color(AppColors.colorPointerNotification),
        child: SvgPicture.asset(
          icon,
          width: DEVICE_WIDTH * 0.026,
          height: DEVICE_HEIGHT * 0.026,
        ),
      ),
    ),
  );
}

class _BubbleArrowPainter extends CustomPainter {
  _BubbleArrowPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubbleArrowPainter oldDelegate) => false;
}

Widget _checkTypeFolderOrImageOrVideo(String path) {
  final String extension = path.split('.').last.toLowerCase();

  if (<String>[
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'webp',
  ].contains(extension)) {
    return Image.file(File(path), width: 100, height: 100, fit: BoxFit.cover);
  } else if (<String>['mp4', 'avi', 'mov', 'wmv'].contains(extension)) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: const Center(child: Icon(Icons.videocam, color: Colors.white)),
    );
  } else {
    return ListTile(
      leading: const Icon(Icons.insert_drive_file),
      title: Text(path.split('/').last),
      subtitle: const Text('ملف غير صورة أو فيديو'),
    );
  }
}

Widget _componentSend() {
  return GetBuilder<VideoCallController>(
    builder: (VideoCallController controller) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.03),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: controller.sendMessage,
                  child: Container(
                    padding: EdgeInsets.all(DEVICE_HEIGHT * 0.015),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.colorLineAndText),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SvgPicture.asset(
                      iconSend,
                      width: DEVICE_WIDTH * 0.04,
                      height: DEVICE_HEIGHT * 0.04,
                    ),
                  ),
                ),
                SizedBox(width: DEVICE_WIDTH * 0.05),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(AppColors.colorWhiteSelectedType),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(
                                AppColors.colorHintText,
                              ).withValues(alpha: 0.1),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (String msg) =>
                              controller.messageContent = msg,
                          decoration: InputDecoration(
                            hintText: 'send_message'.tr,
                            hintStyle: const TextStyle(
                              color: Color(AppColors.colorHintText),
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: DEVICE_WIDTH * 0.06,
                              vertical: DEVICE_HEIGHT * 0.02,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: DEVICE_WIDTH * 0.03,
                        top: DEVICE_HEIGHT * 0.01,
                        child: Container(
                          alignment: Alignment.center,
                          height: DEVICE_HEIGHT * 0.05,
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: DEVICE_WIDTH * 0.05,
                          ),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () =>
                                    controller.pickMedia(sourceType: 'camera'),
                                child: SvgPicture.asset(
                                  iconCamera,
                                  width: DEVICE_WIDTH * 0.04,
                                  height: DEVICE_HEIGHT * 0.03,
                                ),
                              ),
                              SizedBox(width: DEVICE_WIDTH * 0.02),
                              GestureDetector(
                                onTap: () {
                                  controller.toggleisFolderAndImageSend();
                                },
                                child: SvgPicture.asset(
                                  iconPaperClip,
                                  width: DEVICE_WIDTH * 0.05,
                                  height: DEVICE_HEIGHT * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.025),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DEVICE_HEIGHT * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (controller.selectedIndex == 0) {
                          return;
                        } else {
                          controller.scrollController.animateTo(
                            controller.scrollController.offset - 100,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          controller.selectedIndex--;
                          controller.update();
                        }
                      },
                      child: SvgPicture.asset(
                        iconCarouselRight,
                        width: DEVICE_WIDTH * 0.04,
                        height: DEVICE_HEIGHT * 0.04,
                        // ignore: deprecated_member_use
                        color: controller.selectedIndex == 0
                            ? const Color(AppColors.colorBlack)
                            : const Color(AppColors.colorLineAndText),
                      ),
                    ),
                    SizedBox(width: DEVICE_WIDTH * 0.02),
                    GestureDetector(
                      onTap: () {
                        if (controller.selectedIndex <
                            controller.symptomImages.length - 1) {
                          controller.scrollController.animateTo(
                            controller.scrollController.offset + 100,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          controller.selectedIndex++;
                          controller.update();
                        }
                      },
                      child: SvgPicture.asset(
                        iconCarouselLeft,
                        width: DEVICE_WIDTH * 0.04,
                        height: DEVICE_HEIGHT * 0.04,
                        // ignore: deprecated_member_use
                        color:
                            controller.selectedIndex <
                                controller.symptomImages.length - 1
                            ? const Color(AppColors.colorLineAndText)
                            : const Color(AppColors.colorBlack),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              SizedBox(
                width: DEVICE_WIDTH,
                height: DEVICE_HEIGHT * 0.08,
                child: ListView.builder(
                  controller: controller.scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.symptomImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            controller.selectedIndex = index;
                            controller.update();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              controller.symptomImages[index],
                              height: DEVICE_HEIGHT * 0.08,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
