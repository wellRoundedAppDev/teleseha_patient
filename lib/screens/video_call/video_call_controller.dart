import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../general_exports.dart';

class VideoCallController extends GetxController {
  String appId = '2c8437b9443e4607ad16973d4d4c2736';
  String token =
      '007eJxTYHjUP1VKabsN88zzKxQmnvSeZtx0weJabHSH8dwNcmIsIjoKDEbJFibG5kmWJibGqSZmBuaJKYZmlubGKSYpJslG5sZmy2o2ZDQEMjI0FuQwMEIhiM/CUJJaXMLAAACTJBy9';
  String channel = 'test';
  int? remoteUid;
  bool localUserJoined = false;
  late RtcEngine engine;
  bool isMute = false;
  RxBool isCallStarted = false.obs;

  Future<void> toggleMute() async {
    isMute = !isMute;
    await engine.muteAllRemoteAudioStreams(isMute);
    update();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    engine.release();
    await _dispose();
  }

  Future<void> initAgora() async {
    await <Permission>[Permission.microphone, Permission.camera].request();
    final bool cameraGranted = await Permission.camera.isGranted;
    final bool microphoneGranted = await Permission.microphone.isGranted;
    if (!cameraGranted || !microphoneGranted) {
      Get.snackbar(
        'صلاحيات غير متوفرة',
        'من فضلك، قم بتفعيل صلاحيات الكاميرا والميكروفون في إعدادات الجهاز.',
      );
      return;
    }
    try {
      engine = createAgoraRtcEngine();
      await engine.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
      await engine.enableAudioVolumeIndication(
        interval: 200,
        smooth: 3,
        reportVad: true,
      );
      engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            localUserJoined = true;
            update();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            this.remoteUid = remoteUid;
            update();
          },
          onUserOffline:
              (
                RtcConnection connection,
                int remoteUid,
                UserOfflineReasonType reason,
              ) {
                this.remoteUid = null;
                update();
              },
          onError: (ErrorCodeType errorCode, String message) {
            String errorMessage = message;
            if (errorCode == ErrorCodeType.errNoPermission) {
              errorMessage =
                  'تم رفض الإذن. تأكد من أن لديك الإذن للوصول إلى الكاميرا والميكروفون.';
            } else if (errorCode == ErrorCodeType.errNetDown) {
              errorMessage = 'فشل الاتصال بالشبكة. تحقق من اتصالك بالإنترنت.';
            } else {
              errorMessage = 'حدث خطأ غير معروف: $message';
            }
            Get.snackbar('خطأ في الاتصال', errorMessage);
          },
          onRejoinChannelSuccess: (RtcConnection connection, int elapsed) {
            Get.snackbar('تمت إعادة الاتصال', 'لقد تمت إعادة الاتصال بالقناة.');
          },
          onAudioVolumeIndication:
              (
                RtcConnection connection,
                List<AudioVolumeInfo> speakers,
                int totalVolume,
                int elapsed,
              ) {
                for (AudioVolumeInfo speaker in speakers) {
                  if (speaker.volume != null && speaker.volume! > 10) {
                    print('الصوت شغال للمستخدم ${speaker.volume}');
                  } else {
                    print('الصوت هادئ أو ميت للمستخدم ${speaker.uid}');
                  }
                }
              },
        ),
      );

      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await engine.enableAudio();
      await engine.enableVideo();
      await engine.startPreview();
      await engine.joinChannel(
        token: token,
        channelId: channel,
        uid: 0,
        options: const ChannelMediaOptions(),
      );
      isCallStarted.value = true;
      update();
    } catch (e) {
      isCallStarted.value = false;
      update();
      String errorMessage = 'حدث خطأ غير معروف.';
      if (e.toString().contains('Permission denied')) {
        errorMessage =
            'لم يتم منح الصلاحيات المطلوبة للوصول إلى الكاميرا أو الميكروفون.';
      } else if (e.toString().contains('Network error')) {
        errorMessage =
            'خطأ في الشبكة. تأكد من أن الاتصال بالإنترنت يعمل بشكل صحيح.';
      }
      Get.snackbar('خطأ في الاتصال', errorMessage);
      debugPrint('Error during initialization: $e');
    }
  }

  Future<void> _dispose() async {
    await engine.leaveChannel();
    await engine.stopPreview();
    await engine.release();
  }

  Future<void> endCall() async {
    await engine.leaveChannel();
    await engine.stopPreview();
    await engine.release();
    isCallStarted.value = false;
    localUserJoined = false;
    remoteUid = null;
    update();
  }

  Future<void> retryPermissions() async {
    await <Permission>[Permission.microphone, Permission.camera].request();
    if (await Permission.microphone.isGranted &&
        await Permission.camera.isGranted) {
      await initAgora();
    } else {
      Get.snackbar(
        'فشل في الحصول على الصلاحيات',
        'يرجى تمكين الكاميرا والميكروفون من إعدادات الجهاز.',
      );
    }
  }
}
