import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      init: VideoCallController(),
      builder: (VideoCallController controller) {
        final bool isCallStarted = controller.isCallStarted.value;

        Widget localVideoWidget() {
          if (controller.remoteUid != null && controller.channel.isNotEmpty) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: DEVICE_HEIGHT,
              child: controller.engine != null
                  ? controller.isVideoMuted
                        ? Image.asset(imageDoctor, fit: BoxFit.cover)
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
              Text('test'),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: DEVICE_HEIGHT,
                child: controller.isSwapped
                    ? remoteVideoWidget()
                    : localVideoWidget(),
              ),

              Positioned(
                top: 50,
                right: 20,
                child: SizedBox(
                  width: DEVICE_WIDTH * 0.22,
                  height: DEVICE_HEIGHT * 0.15,
                  child: controller.isSwapped
                      ? localVideoWidget()
                      : remoteVideoWidget(),
                ),
              ),

              Positioned(
                top: 165,
                right: 45,
                child: GestureDetector(
                  onTap: () {
                    controller.swapVideoPosition();
                  },
                  child: SvgPicture.asset(iconRotation, width: 35, height: 35),
                ),
              ),
            ],
          ),
          floatingActionButton: GetBuilder<VideoCallController>(
            builder: (VideoCallController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: controller.toggleVideoMute,
                    backgroundColor: controller.isVideoMuted
                        ? Colors.red
                        : Colors.blue,
                    child: Icon(
                      controller.isVideoMuted
                          ? Icons.videocam_off
                          : Icons.videocam,
                    ),
                  ),
                  FloatingActionButton.extended(
                    onPressed: controller.isCallStarted.value
                        ? () async {
                            await controller.endCall();
                          }
                        : null,
                    label: const Text('إنهاء المكالمة'),
                    icon: const Icon(Icons.call_end),
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: controller.toggleMute,
                    backgroundColor: controller.isMute
                        ? Colors.red
                        : Colors.blue,
                    child: Icon(controller.isMute ? Icons.mic_off : Icons.mic),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
