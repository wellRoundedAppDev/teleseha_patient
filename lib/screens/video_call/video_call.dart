import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_svg/svg.dart';

import '../../general_exports.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key});

  // controller.isVideoMuted
  //                           ? Image.asset(imageDoctor, fit: BoxFit.cover)
  //  controller.isRemoteVideoMuted
  //                                         ? Image.asset(
  //                                             imageDoctor,
  //                                             fit: BoxFit.cover,
  //                                           )
  //                                         :

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoCallController>(
      init: VideoCallController(),
      builder: (VideoCallController controller) {
        final bool isCallStarted = controller.isCallStarted.value;

        return Scaffold(
          body: Stack(
            children: <Widget>[
              if (controller.remoteUid != null && controller.channel.isNotEmpty)
                SizedBox(
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
                )
              else
                const Center(child: Text('بانتظار انضمام الطرف الآخر...')),
              if (isCallStarted)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: DEVICE_HEIGHT * 0.08,
                    horizontal: DEVICE_WIDTH * 0.07,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(128, 128, 128, 0.40),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: SizedBox(
                                width: DEVICE_WIDTH * 0.22,
                                height: DEVICE_HEIGHT * 0.15,
                                child: controller.engine != null
                                    ? controller.isRemoteVideoMuted
                                          ? Image.asset(
                                              imageDoctor,
                                              fit: BoxFit.cover,
                                            )
                                          : AgoraVideoView(
                                              controller:
                                                  VideoViewController.remote(
                                                    rtcEngine:
                                                        controller.engine,
                                                    canvas: VideoCanvas(
                                                      uid: controller.remoteUid,
                                                    ),
                                                    connection: RtcConnection(
                                                      channelId:
                                                          controller.channel,
                                                    ),
                                                  ),
                                            )
                                    : const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 28,
                          child: SvgPicture.asset(
                            iconRotation,
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ],
                    ),
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
