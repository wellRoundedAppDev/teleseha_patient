import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      builder: (VideoCallController controller) {
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
                        child: Image.asset(imageDoctor, fit: BoxFit.cover),
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
            return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
          }
        }

        Widget remoteVideoWidget() {
          if (controller.remoteUid == null || controller.remoteUid == 0) {
            return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
          }
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(128, 128, 128, 0.40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: controller.isRemoteVideoMuted
                  ? Image.asset(imageDoctor, fit: BoxFit.cover)
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        iconBack,
                        width: DEVICE_WIDTH * 0.04,
                        height: DEVICE_HEIGHT * 0.02,
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
                  GestureDetector(
                    child: DraggableScrollableSheet(
                      controller: controller.bottomSheetController,
                      initialChildSize:
                          220 / MediaQuery.of(context).size.height,
                      minChildSize: 0.15,
                      maxChildSize: 0.9,
                      builder:
                          (
                            BuildContext context,
                            ScrollController scrollController,
                          ) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
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
                                            controller
                                                    .hasNavigatedToDoctorInfo =
                                                true;
                                            controller.isShowTextfield = false;
                                            controller.update();
                                          } else if (notification.extent <=
                                                  0.7 &&
                                              controller
                                                  .hasNavigatedToDoctorInfo) {
                                            controller
                                                    .hasNavigatedToDoctorInfo =
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
                  ),
                  if (controller.isRotateFolderAndImageSend)
                    Obx(() {
                      final double sheetSize = controller.bottomSheetSize.value;
                      final double bottomOffset = sheetSize * DEVICE_HEIGHT;
                      return Positioned(
                        bottom: bottomOffset - 50,
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
                                      sourceType: 'image',
                                    ),
                                    child: SvgPicture.asset(
                                      iconStudio,
                                      width: 23,
                                      height: 23,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
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
                            Get.back();
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
      final List<String> dates = logsGrouped.keys.toList();
      final String today = 'اليوم';
      final List<ChatLog> messages = logsGrouped[today] ?? <ChatLog>[];

      return SingleChildScrollView(
        controller: scrollController,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 300),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
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
              const SizedBox(height: 25),
              if (controller.isShowTextfield)
                _componentSend()
              else
                const SizedBox(),
              SizedBox(height: DEVICE_HEIGHT * 0.03),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DEVICE_HEIGHT * 0.03,
                    ),
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
              // Obx(() {
              //   final path =
              //       controller.selectedImagePathFromGallery.value;
              //   if (path.isNotEmpty) {
              //     return Image.file(
              //       File(path),
              //       width: 100,
              //       height: 100,
              //       fit: BoxFit.cover,
              //     );
              //   } else {
              //     return SizedBox();
              //   }
              // }),
              // Obx(() {
              //   final String path = controller
              //       .selectedImagePathFromCamera
              //       .value;
              //   if (path.isNotEmpty) {
              //     return Image.file(
              //       File(path),
              //       width: 100,
              //       height: 100,
              //       fit: BoxFit.cover,
              //     );
              //   } else {
              //     return const SizedBox();
              //   }
              // }),
              // Obx(() {
              //   if (controller.selectedFilePaths.isEmpty) {
              //     return const Text('لم يتم اختيار أي ملف');
              //   }
              //   return ListView.builder(
              //     shrinkWrap: true,
              //     itemCount:
              //         controller.selectedFilePaths.length,
              //     itemBuilder:
              //         (BuildContext context, int index) {
              //           final String path = controller
              //               .selectedFilePaths[index];
              //           return Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child:
              //                 _checkTypeFolderOrImageOrVideo(
              //                   path,
              //                 ),
              //           );
              //         },
              //   );
              // }),
              SizedBox(height: DEVICE_HEIGHT * 0.05),
              SizedBox(
                height: DEVICE_HEIGHT,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          today,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ChatLog log = messages[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4,
                            ),
                            child: Text(log.message),
                          );
                        },
                      ),
                    ),
                    _componentSend(),
                  ],
                ),
              ),
            ],
          ),
        ),
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

// Widget _checkTypeFolderOrImageOrVideo(String path) {
//   final String extension = path.split('.').last.toLowerCase();

//   if (<String>[
//     'jpg',
//     'jpeg',
//     'png',
//     'gif',
//     'bmp',
//     'webp',
//   ].contains(extension)) {
//     return Image.file(File(path), width: 100, height: 100, fit: BoxFit.cover);
//   } else if (<String>['mp4', 'avi', 'mov', 'wmv'].contains(extension)) {
//     return Container(
//       width: 100,
//       height: 100,
//       color: Colors.black,
//       child: const Center(child: Icon(Icons.videocam, color: Colors.white)),
//     );
//   } else {
//     return ListTile(
//       leading: const Icon(Icons.insert_drive_file),
//       title: Text(path.split('/').last),
//       subtitle: const Text('ملف غير صورة أو فيديو'),
//     );
//   }
// }

Widget _componentSend() {
  return GetBuilder<VideoCallController>(
    builder: (VideoCallController controller) {
      return Padding(
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
      );
    },
  );
}
