// import 'dart:ui';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../general_exports.dart';

// class VideoCall extends StatelessWidget {
//   const VideoCall({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VideoCallController>(
//       builder: (VideoCallController controller) {
//         final String minutes = (controller.secondsLeft ~/ 60)
//             .toString()
//             .padLeft(2, '0');
//         final String seconds = (controller.secondsLeft % 60).toString().padLeft(
//           2,
//           '0',
//         );
//         Widget localVideoWidget() {
//           if (controller.localUserJoined) {
//             return SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: DEVICE_HEIGHT,
//               child: controller.isVideoMuted
//                   ? Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadiusGeometry.circular(18),
//                         border: Border.all(
//                           width: 2,
//                           color: const Color.fromRGBO(128, 128, 128, 0.40),
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadiusGeometry.circular(18),
//                         child: Image.asset(imageDoctor, fit: BoxFit.cover),
//                       ),
//                     )
//                   : AgoraVideoView(
//                       controller: VideoViewController(
//                         rtcEngine: controller.engine,
//                         canvas: const VideoCanvas(
//                           uid: 0,
//                           renderMode: RenderModeType.renderModeHidden,
//                         ),
//                       ),
//                     ),
//             );
//           } else {
//             return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
//           }
//         }

//         Widget remoteVideoWidget() {
//           if (controller.remoteUid == null || controller.remoteUid == 0) {
//             return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
//           }
//           return Container(
//             padding: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               color: const Color.fromRGBO(128, 128, 128, 0.40),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(18),
//               child: controller.isRemoteVideoMuted
//                   ? Image.asset(imageDoctor, fit: BoxFit.cover)
//                   : AgoraVideoView(
//                       controller: VideoViewController.remote(
//                         rtcEngine: controller.engine,
//                         canvas: VideoCanvas(uid: controller.remoteUid),
//                         connection: RtcConnection(
//                           channelId: controller.channel,
//                         ),
//                       ),
//                     ),
//             ),
//           );
//         }

//         return Scaffold(
//           body: Stack(
//             children: <Widget>[
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: DEVICE_HEIGHT,
//                 child: controller.isSwapped
//                     ? remoteVideoWidget()
//                     : localVideoWidget(),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
//                 padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.06),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     const SizedBox(),
//                     Container(
//                       margin: EdgeInsets.only(right: DEVICE_WIDTH * 0.14),
//                       child: CustomText(
//                         text: '[$minutes:$seconds]',
//                         fontSize: 24,
//                         type: CustomTextType.title,
//                         color: const Color(AppColors.colorWhiteSelectedType),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: SvgPicture.asset(
//                         iconBack,
//                         width: DEVICE_WIDTH * 0.04,
//                         height: DEVICE_HEIGHT * 0.02,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: DEVICE_HEIGHT * 0.09,
//                 right: DEVICE_WIDTH * 0.05,
//                 child: SizedBox(
//                   width: DEVICE_WIDTH * 0.25,
//                   height: DEVICE_HEIGHT * 0.17,
//                   child: controller.isSwapped
//                       ? localVideoWidget()
//                       : remoteVideoWidget(),
//                 ),
//               ),
//               Positioned(
//                 top: DEVICE_HEIGHT * 0.24,
//                 right: DEVICE_WIDTH * 0.135,
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.swapVideoPosition();
//                   },
//                   child: SvgPicture.asset(
//                     iconRotation,
//                     width: DEVICE_WIDTH * 0.04,
//                     height: DEVICE_HEIGHT * 0.04,
//                   ),
//                 ),
//               ),
//               DraggableScrollableSheet(
//                 controller: controller.bottomSheetController,
//                 initialChildSize: 0.6,
//                 minChildSize: 0.15,
//                 maxChildSize: 0.9,
//                 builder:
//                     (BuildContext context, ScrollController scrollController) {
//                       return Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: DEVICE_HEIGHT * 0.03,
//                         ),
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(40),
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20),
//                           ),
//                         // ),
//                         // child: ListView(
//                         //   controller: scrollController,
//                         //   children: <Widget>[
//
//                         //     const SizedBox(height: 20),
//                         //     const Text(
//                         //       'تفاصيل المكالمة',
//                         //       style: TextStyle(fontSize: 18),
//                         //     ),
//                         //     const SizedBox(height: 15),
//                         //     const Text(
//                         //       'تفاصيل المكالمة',
//                         //       style: TextStyle(fontSize: 18),
//                         //     ),
//                         //     const SizedBox(height: 10),
//                         //     const Text(
//                         //       'تفاصيل المكالمة',
//                         //       style: TextStyle(fontSize: 18),
//                         //     ),
//                         //     const SizedBox(height: 34),
//                         //   ],
//                         // ),
//                         // child: ListView(
//                         //   controller: scrollController,
//                         //   children: <Widget>[
//                         //     Center(
//                         //       child: Container(
//                         //         width: DEVICE_WIDTH * 0.24,
//                         //         height: DEVICE_HEIGHT * 0.01,
//                         //         decoration: BoxDecoration(
//                         //           borderRadius: BorderRadius.circular(6),
//                         //           color: const Color(
//                         //             AppColors.colorLineScrollBottomSheet,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //     const SizedBox(height: 20),
//                         //     const Text(
//                         //       'تفاصيل المكالمة',
//                         //       style: TextStyle(fontSize: 18),
//                         //     ),
//                         //     const SizedBox(height: 20),
//                         //     ElevatedButton(
//                         //       onPressed: () {},
//                         //       child: const Text('إنهاء المكالمة'),
//                         //     ),
//                         //   ],
//                         // ),
//                       );
//                     },
//               ),
//               Obx(() {
//                 final double sheetSize = controller.bottomSheetSize.value;
//                 final double bottomOffset = sheetSize * DEVICE_HEIGHT;
//                 return Positioned(
//                   bottom: bottomOffset + 4,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     width: DEVICE_WIDTH,
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         _buildActionButton(
//                           icon: iconVideo,
//                           onPressed: controller.toggleVideoMute,
//                           isActive: !controller.isVideoMuted,
//                         ),
//                         _buildActionButton(
//                           icon: iconPhone,
//                           onPressed: () async {
//                             await controller.endCall();
//                             Get.back();
//                           },
//                           isActive: true,
//                         ),
//                         _buildActionButton(
//                           icon: iconVoice,
//                           onPressed: controller.toggleMute,
//                           isActive: !controller.isMute,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// Widget _buildActionButton({
//   required String icon,
//   required VoidCallback onPressed,
//   required bool isActive,
// }) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(30),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
//       child: FloatingActionButton(
//         heroTag: icon,
//         onPressed: onPressed,
//         backgroundColor: isActive
//             ? const Color(AppColors.colorBackgroundIconCall)
//             : const Color(AppColors.colorPointerNotification),
//         child: SvgPicture.asset(
//           icon,
//           width: DEVICE_WIDTH * 0.026,
//           height: DEVICE_HEIGHT * 0.026,
//         ),
//       ),
//     ),
//   );
// }

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
              DraggableScrollableSheet(
                controller: controller.bottomSheetController,
                initialChildSize: 190 / MediaQuery.of(context).size.height,
                minChildSize: 0.15,
                maxChildSize: 0.9,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: DEVICE_HEIGHT * 0.03,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight:
                                  190 / MediaQuery.of(context).size.height,
                            ),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 10),
                                Center(
                                  child: Container(
                                    width: DEVICE_WIDTH * 0.24,
                                    height: DEVICE_HEIGHT * 0.01,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color(
                                        AppColors.colorLineScrollBottomSheet,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(
                                        DEVICE_HEIGHT * 0.015,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          AppColors.colorLineAndText,
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: SvgPicture.asset(
                                        iconSend,
                                        width: DEVICE_WIDTH * 0.04,
                                        height: DEVICE_HEIGHT * 0.04,
                                      ),
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.05),
                                    Expanded(
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(
                                                AppColors
                                                    .colorWhiteSelectedType,
                                              ),
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
                                              // controller: controller.filter,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'send_message'.tr,
                                                hintStyle: const TextStyle(
                                                  color: Color(
                                                    AppColors.colorHintText,
                                                  ),
                                                  fontSize: 14,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal:
                                                          DEVICE_WIDTH * 0.06,
                                                      vertical:
                                                          DEVICE_HEIGHT * 0.02,
                                                    ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: DEVICE_WIDTH * 0.05,
                                            top: DEVICE_HEIGHT * 0.013,
                                            child: Row(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  iconCamera,
                                                  width: DEVICE_WIDTH * 0.04,
                                                  height: DEVICE_HEIGHT * 0.03,
                                                ),
                                                SizedBox(
                                                  width: DEVICE_WIDTH * 0.02,
                                                ),
                                                SvgPicture.asset(
                                                  iconPaperClip,
                                                  width: DEVICE_WIDTH * 0.05,
                                                  height: DEVICE_HEIGHT * 0.035,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'تفاصيل المكالمة',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
