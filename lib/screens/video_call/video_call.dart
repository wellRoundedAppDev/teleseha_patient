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
                initialChildSize: 0.15,
                minChildSize: 0.15,
                maxChildSize: 0.5,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          controller: scrollController,
                          children: <Widget>[
                            const Center(child: Icon(Icons.drag_handle)),
                            const SizedBox(height: 10),
                            const Text(
                              'تفاصيل المكالمة',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 20),
                            // هنا تقدر تضيف أي عناصر (أزرار، معلومات، إلخ)
                            ElevatedButton(
                              onPressed: () {
                                // مثال على إنهاء المكالمة
                              },
                              child: const Text('إنهاء المكالمة'),
                            ),
                          ],
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
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: FloatingActionButton(
        heroTag: icon,
        onPressed: onPressed,
        backgroundColor: isActive
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
