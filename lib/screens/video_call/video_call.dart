import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../general_exports.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VideoCallController>(
        builder: (controller) {
          bool isCallStarted = controller.isCallStarted.value;
          return Stack(
            children: [
              if (isCallStarted)
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Center(
                      child: controller.localUserJoined
                          ? AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: controller.engine,
                                canvas: const VideoCanvas(uid: 0),
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
              Center(
                child: isCallStarted
                    ? _remoteVideo(controller)
                    : const Text('اضغط على الزر لبدء المكالمة'),
              ),
            ],
          );
        },
      ),
      floatingActionButton: GetBuilder<VideoCallController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.extended(
                onPressed: controller.isCallStarted.value
                    ? null
                    : () async {
                        await controller.initAgora();
                      },
                label: const Text("بدء المكالمة"),
                icon: const Icon(Icons.video_call),
              ),
              const SizedBox(height: 10),
              FloatingActionButton.extended(
                onPressed: controller.isCallStarted.value
                    ? () async {
                        await controller.endCall();
                      }
                    : null,
                label: const Text("إنهاء المكالمة"),
                icon: const Icon(Icons.call_end),
                backgroundColor: Colors.red,
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: controller.toggleMute,
                child: Icon(controller.isMute ? Icons.mic_off : Icons.mic),
                backgroundColor: controller.isMute ? Colors.red : Colors.blue,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _remoteVideo(VideoCallController controller) {
    if (controller.remoteUid != null) {
      return Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          width: 50,
          height: 50,
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: controller.engine,
              canvas: VideoCanvas(uid: controller.remoteUid),
              connection: RtcConnection(channelId: controller.channel),
            ),
          ),
        ),
      );
    } else {
      return const Text(
        'بانتظار انضمام الطرف الآخر...',
        textAlign: TextAlign.center,
      );
    }
  }
}
