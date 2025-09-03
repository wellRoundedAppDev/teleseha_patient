import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../general_exports.dart';

class VideoCallController extends GetxController {
  String appId = '2c8437b9443e4607ad16973d4d4c2736';
  String token =
      '007eJxTYKix1zZ++GC3vJrZzE0TbuYJmJwRtou7bPz0peQVnc3vNPgUGIySLUyMzZMsTUyMU03MDMwTUwzNLM2NU0xSTJKNzI3N1K9vy2gIZGTQ6TBgYWSAQBCfhaEktbiEgQEA0kEdcQ==';
  String channel = 'test';
  int? remoteUid;
  bool localUserJoined = false;
  late RtcEngine engine;
  bool isMute = false;
  RxBool isCallStarted = false.obs;
  bool isVideoMuted = false;
  bool isRemoteVideoMuted = false;
  int? localUid;
  bool isSwapped = false;
  bool isRotateFolderAndImageSend = false;
  int selectedIndex = 2;

  final ScrollController scrollController = ScrollController();

  int secondsLeft = 900;
  late Timer _timer;

  BookingsController bookings = Get.put(BookingsController());
  bool get hasParticipant => localUserJoined;

  final DraggableScrollableController bottomSheetController =
      DraggableScrollableController();

  RxDouble bottomSheetSize = 0.35.obs;
  RxDouble bottomSheetSizeStudio = 0.07.obs;
  bool showNewPage = false;

  // start picker
  final Rxn<File> selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();
  RxString selectedImagePathFromGallery = ''.obs;
  RxString selectedImagePathFromCamera = ''.obs;
  RxList<String> selectedFilePaths = <String>[].obs;
  // end picker

  @override
  void onInit() {
    super.onInit();
    bottomSheetController.addListener(() {
      bottomSheetSize.value = bottomSheetController.size;
    });
    bottomSheetController.addListener(() {
      bottomSheetSizeStudio.value = bottomSheetController.size;
    });

    bottomSheetController.addListener(() {
      final position = bottomSheetController.size;
      if (position >= 0.7 && !showNewPage) {
        showNewPage = true;
        update();
      }
      if (position < 0.7 && showNewPage) {
        showNewPage = false;
        update();
      }
    });
  }

  // start file picker and image picker
  Future<void> pickMedia({required String sourceType}) async {
    switch (sourceType) {
      case 'image':
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        if (result != null && result.files.isNotEmpty) {
          final String? filePath = result.files.single.path;
          if (filePath != null) {
            selectedImagePathFromGallery.value = filePath;
            isRotateFolderAndImageSend = false;
          }
        } else {
          consoleLog('❌ User canceled image picker.');
        }
        break;

      case 'camera':
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
        );
        if (photo != null) {
          selectedImagePathFromCamera.value = photo.path;
          isRotateFolderAndImageSend = false;
        } else {
          consoleLog('❌ User canceled camera.');
        }
        break;

      case 'file':
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
        );
        if (result != null) {
          selectedFilePaths.value = result.paths.whereType<String>().toList();
          isRotateFolderAndImageSend = false;
        } else {
          consoleLog('❌ User canceled file picker.');
        }
        break;

      default:
        consoleLog('⚠️ Invalid source type: $sourceType');
    }

    update();
  }
  // end file picker and image picker

  void toggleisFolderAndImageSend() {
    isRotateFolderAndImageSend = !isRotateFolderAndImageSend;
    update();
  }

  void startTimer() {
    if (!hasParticipant) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (secondsLeft > 0) {
        secondsLeft--;
        update();
      } else {
        _timer.cancel();
        onTimerFinished();
      }
    });
  }

  void onTimerFinished() {
    leaveChannel();
  }

  Future<void> leaveChannel() async {
    await engine.leaveChannel();
    // Get.back();
  }

  Future<void> joinAsFirstUser() async {
    localUserJoined = true;
    bookings.currentStep = 2;
    update();
    bookings.update();
    await initAgora();
    Get.toNamed(routeVideoCall);
  }

  Future<void> toggleMute() async {
    isMute = !isMute;
    await engine.muteAllRemoteAudioStreams(isMute);
    update();
  }

  Future<void> toggleVideoMute() async {
    if (localUid != null) {
      isVideoMuted = !isVideoMuted;
      await engine.muteLocalVideoStream(isVideoMuted);
      update();
    }
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    engine.release();
    await _dispose();
  }

  Future<void> initAgora() async {
    await Future.delayed(const Duration(seconds: 2));
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
            localUid = connection.localUid;
            localUserJoined = true;
            update();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            this.remoteUid = remoteUid;
            bookings.currentStep = 2;
            bookings.update();
            startTimer();
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

          onUserMuteVideo: (RtcConnection connection, int uid, bool muted) {
            if (uid == localUid) {
              isVideoMuted = muted;
            } else {
              isRemoteVideoMuted = muted;
            }
            update();
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
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
          autoSubscribeVideo: true,
          autoSubscribeAudio: true,
        ),
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

  void swapVideoPosition() {
    isSwapped = !isSwapped;
    update();
  }

  final List<String> symptomImages = <String>[
    imageNostrils,
    imageFrontNose,
    imageLowerEyelid,
    imageNostrils,
    imageFrontNose,
    imageLowerEyelid,
  ];
}
