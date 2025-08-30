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
        final bool isCallStarted = controller.isCallStarted.value;
        final String minutes = (controller.secondsLeft ~/ 60)
            .toString()
            .padLeft(2, '0');
        final String seconds = (controller.secondsLeft % 60).toString().padLeft(
          2,
          '0',
        );
        Widget localVideoWidget() {
          if (controller.remoteUid != null && controller.channel.isNotEmpty) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: DEVICE_HEIGHT,
              child: controller.engine != null
                  ? controller.isVideoMuted
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(18),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromRGBO(
                                  128,
                                  128,
                                  128,
                                  0.40,
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(18),
                              child: Image.asset(
                                imageDoctor,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: controller.engine,
                              canvas: VideoCanvas(uid: controller.localUid),
                            ),
                          )
                  : const CircularProgressIndicator(),
            );
          } else {
            return const Center(child: Text('بانتظار انضمام الطرف الآخر...'));
          }
        }

        Widget remoteVideoWidget() {
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(128, 128, 128, 0.40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: controller.engine == null
                  ? const Center(child: CircularProgressIndicator())
                  : controller.isRemoteVideoMuted
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
            ],
          ),
          floatingActionButton: GetBuilder<VideoCallController>(
            builder: (VideoCallController controller) {
              return Container(
                margin: EdgeInsets.only(right: DEVICE_WIDTH * 0.14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: FloatingActionButton(
                          onPressed: controller.toggleVideoMute,
                          backgroundColor: (controller.isVideoMuted
                              ? const Color(AppColors.colorPointerNotification)
                              : const Color(AppColors.colorBackgroundIconCall)),
                          child: SvgPicture.asset(
                            iconVideo,
                            width: DEVICE_WIDTH * 0.026,
                            height: DEVICE_HEIGHT * 0.026,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: FloatingActionButton(
                          onPressed: controller.isCallStarted.value
                              ? () async {
                                  await controller.endCall();
                                }
                              : null,
                          backgroundColor: const Color(
                            AppColors.colorPointerNotification,
                          ),
                          child: SvgPicture.asset(
                            iconPhone,
                            width: DEVICE_WIDTH * 0.026,
                            height: DEVICE_HEIGHT * 0.026,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: FloatingActionButton(
                          onPressed: controller.toggleMute,
                          backgroundColor: (controller.isMute
                              ? const Color(AppColors.colorPointerNotification)
                              : const Color(AppColors.colorBackgroundIconCall)),
                          child: SvgPicture.asset(
                            iconVoice,
                            width: DEVICE_WIDTH * 0.026,
                            height: DEVICE_HEIGHT * 0.026,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
