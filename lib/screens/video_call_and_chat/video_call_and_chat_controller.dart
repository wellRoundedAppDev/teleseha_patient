// import 'dart:async';
// import 'dart:io';

// import 'package:agora_chat_sdk/agora_chat_sdk.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../general_exports.dart';

// class ChatLog {
//   ChatLog({
//     required this.message,
//     required this.timestamp,
//     required this.msgId,
//     required this.isSentByMe,
//     this.isDelivered = false,
//     this.filePath,
//   });
//   final String message;
//   final DateTime timestamp;
//   final String msgId;
//   final bool isSentByMe;
//   bool isDelivered;
//   final String? filePath;
// }

// class VideoCallController extends GetxController {
//   String appId = '2c8437b9443e4607ad16973d4d4c2736';
//   String token =
//       '007eJxTYDA78fKfYc2K29uEKjRNFmufDJ3Hk6O43HeayGvHB0vj+RoUGIySLUyMzZMsTUyMU03MDMwTUwzNLM2NU0xSTJKNzI3Npq3fmdEQyMhwKTmWkZEBAkF8FoaS1OISBgYAG+Qewg==';
//   String channel = 'test';
//   int? remoteUid;
//   bool localUserJoined = false;
//   late RtcEngine engine;
//   bool isMute = false;
//   RxBool isCallStarted = false.obs;
//   bool isVideoMuted = false;
//   bool isRemoteVideoMuted = false;
//   int? localUid;
//   static const String appKey = '711376482#1582448';
//   bool isSwapped = false;
//   bool isRotateFolderAndImageSend = false;
//   int selectedIndex = 2;

//   final ScrollController scrollController = ScrollController();
//   late ScrollController firstPageScrollController;

//   int secondsLeft = 900;
//   Timer? _timer;
//   bool isOpenContainerRange = false;
//   RxBool isCallEnded = false.obs;

//   BookingsController bookings = Get.put(BookingsController());
//   bool get hasParticipant => localUserJoined || remoteUid != null;
//   // bool get hasParticipant => localUserJoined;

//   final DraggableScrollableController bottomSheetController =
//       DraggableScrollableController();

//   RxDouble bottomSheetSize = 0.35.obs;
//   RxDouble bottomSheetSizePageChat = 0.0.obs;
//   bool hasNavigatedToDoctorInfo = false;
//   bool isShowTextfield = true;

//   // start picker
//   final Rxn<File> selectedImage = Rxn<File>();
//   final ImagePicker _picker = ImagePicker();
//   RxString selectedImagePathFromGallery = ''.obs;
//   RxString selectedImagePathFromCamera = ''.obs;
//   RxList<String> selectedFilePaths = <String>[].obs;
//   // end picker

//   // start chat
//   // final RxList<ChatLog> logText = <ChatLog>[].obs;
//   List<ChatLog> get logText => dummyMessages;

//   String? currentUserId;
//   String? chatId;
//   String? messageContent;
//   final double maxChildSize = 0.9;

//   // end chat

//   @override
//   void onInit() {
//     super.onInit();
//     bottomSheetController.addListener(() {
//       bottomSheetSize.value = bottomSheetController.size;
//     });
//     bottomSheetController.addListener(() {
//       bottomSheetSizePageChat.value = bottomSheetController.size;
//     });

//     ever(isCallEnded, (bool value) {
//       if (value) {
//         stopTimer();
//       }
//     });
//   }

//   // start chat function
//   Future<void> initSDK() async {
//     final ChatOptions options = ChatOptions(
//       appKey: appKey,
//       autoLogin: false,
//       debugMode: true,
//       requireDeliveryAck: true,
//     );
//     options.enableHWPush();
//     await ChatClient.getInstance.init(options);
//     await ChatClient.getInstance.startCallback();
//   }

//   void addChatListener() {
//     ChatClient.getInstance.addConnectionEventHandler(
//       'CONNECTION_UNIQUE_HANDLER_ID',
//       ConnectionEventHandler(
//         onConnected: () => addLogToConsole('onConnected'),
//         onDisconnected: () => addLogToConsole('onDisconnected'),
//       ),
//     );

//     ChatClient.getInstance.chatManager.addEventHandler(
//       'UNIQUE_HANDLER_ID',
//       ChatEventHandler(
//         onMessagesReceived: onMessagesReceived,
//         onMessagesDelivered: (List<ChatMessage> messages) {
//           for (ChatMessage msg in messages) {
//             addLogToConsole('message, from: ${msg.from} is delivered');
//             for (final ChatLog log in logText) {
//               if (log.msgId == msg.msgId) {
//                 log.isDelivered = true;
//                 break;
//               }
//             }
//             update();
//           }
//         },
//       ),
//     );

//     ChatClient.getInstance.chatManager.addMessageEvent(
//       'UNIQUE_HANDLER_ID',
//       ChatMessageEvent(
//         onError: (String msgId, ChatMessage msg, ChatError error) {
//           addLogToConsole(
//             'send message failed, code: ${error.code}, desc: ${error.description}',
//           );
//         },
//       ),
//     );
//   }

//   Future<void> signOut() async {
//     try {
//       await ChatClient.getInstance.logout();
//       addLogToConsole('sign out succeed');
//       currentUserId = null;
//       update();
//     } on ChatError catch (e) {
//       addLogToConsole(
//         'sign out failed, code: ${e.code}, desc: ${e.description}',
//       );
//     }
//   }

//   Future<void> sendMessage() async {
//     if (chatId == null ||
//         messageContent == null ||
//         messageContent!.trim().isEmpty) {
//       addLogToConsole('single chat id or message content is null');
//       return;
//     }

//     final String content = messageContent!;
//     final ChatMessage msg = ChatMessage.createTxtSendMessage(
//       targetId: chatId!,
//       content: content,
//     );

//     try {
//       await ChatClient.getInstance.chatManager.sendMessage(msg);

//       final ChatLog log = ChatLog(
//         message: content,
//         timestamp: DateTime.now(),
//         msgId: msg.msgId,
//         isSentByMe: true,
//       );

//       logText.add(log);
//       update();
//     } on ChatError catch (e) {
//       addLogToConsole(
//         'send message failed, code: ${e.code}, desc: ${e.description}',
//       );
//     }
//   }

//   void onMessagesReceived(List<ChatMessage> messages) {
//     for (ChatMessage msg in messages) {
//       if (msg.body.type == MessageType.TXT && msg.from != currentUserId) {
//         final ChatTextMessageBody body = msg.body as ChatTextMessageBody;

//         if (msg.from != currentUserId) {
//           addLogToConsole(body.content);
//         }
//       } else {
//         addLogToConsole(
//           'receive message type: ${msg.body.type}, from: ${msg.from}',
//         );
//       }
//     }
//   }

//   void addIncomingMessage(ChatMessage msg) {
//     final ChatTextMessageBody body = msg.body as ChatTextMessageBody;

//     final ChatLog log = ChatLog(
//       message: body.content,
//       timestamp: DateTime.now(),
//       msgId: msg.msgId,
//       isSentByMe: false,
//       isDelivered: true,
//     );

//     logText.add(log);
//     update();
//   }

//   void addLogToConsole(String log, {String msgId = ''}) {
//     logText.add(
//       ChatLog(
//         message: log,
//         timestamp: DateTime.now(),
//         isSentByMe: true,
//         msgId: msgId,
//       ),
//     );

//     update();
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (scrollController.hasClients) {
//         scrollController.jumpTo(scrollController.position.maxScrollExtent);
//       }
//     });
//   }

//   Map<String, List<ChatLog>> groupLogsByDate(List<ChatLog> logs) {
//     final Map<String, List<ChatLog>> grouped = <String, List<ChatLog>>{};

//     for (ChatLog log in logs) {
//       final String dateGroup = formatDateGroup(log.timestamp);

//       if (!grouped.containsKey(dateGroup)) {
//         grouped[dateGroup] = <ChatLog>[];
//       }

//       grouped[dateGroup]!.add(log);
//     }

//     return grouped;
//   }

//   String formatDateGroup(DateTime date) {
//     final DateTime now = DateTime.now();
//     final DateTime today = DateTime(now.year, now.month, now.day);
//     final DateTime yesterday = today.subtract(const Duration(days: 1));
//     final DateTime messageDate = DateTime(date.year, date.month, date.day);

//     if (messageDate == today) {
//       return 'اليوم';
//     } else if (messageDate == yesterday) {
//       return 'أمس';
//     } else {
//       return DateFormat('dd/MM/yyyy').format(messageDate);
//     }
//   }

//   String get timeString {
//     return DateTime.now().toString().split('.').first;
//   }

//   Future<void> signInChat({
//     required String userId,
//     required String token,
//   }) async {
//     try {
//       await initSDK();
//       await ChatClient.getInstance.loginWithToken(userId, token);

//       currentUserId = userId;

//       addChatListener();
//       joinAsFirstUser();
//       if (userId == 'doctor') {
//         chatId = 'patient';
//       } else if (userId == 'patient') {
//         chatId = 'doctor';
//       }
//     } on ChatError catch (e) {
//       consoleLog(e);
//       if (e.code == 200 || e.code == 218) {
//         joinAsFirstUser();
//         currentUserId = userId;
//         addChatListener();
//         if (userId == 'doctor') {
//           chatId = 'patient';
//         } else if (userId == 'patient') {
//           chatId = 'doctor';
//         }
//       }
//     } catch (e) {
//       consoleLog('Unknown error during login: $e');
//     }

//     currentUserId = userId;
//     update();
//   }

//   String formatTimestamp(DateTime timestamp) {
//     int hour = timestamp.hour;
//     final int minute = timestamp.minute;
//     final String period = hour >= 12 ? 'PM' : 'AM';

//     if (hour == 0) {
//       hour = 12;
//     } else if (hour > 12) {
//       hour -= 12;
//     }

//     final String formattedHour = hour.toString();
//     final String formattedMinute = minute.toString().padLeft(2, '0');

//     return '$formattedHour:$formattedMinute $period';
//   }

//   void addImageOrFileOrMessage(String path) {
//     final ChatLog newLog = ChatLog(
//       message: '',
//       timestamp: DateTime.now(),
//       isSentByMe: true,
//       filePath: path,
//       msgId: '',
//     );

//     logText.add(newLog);
//     update();
//   }

//   // end chat function

//   // start file picker and image picker
//   Future<void> pickMedia({required String sourceType}) async {
//     switch (sourceType) {
//       case 'image':
//         final FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.image,
//         );
//         if (result != null && result.files.isNotEmpty) {
//           final String? filePath = result.files.single.path;
//           if (filePath != null) {
//             selectedImagePathFromGallery.value = filePath;
//             addImageOrFileOrMessage(filePath);
//             isRotateFolderAndImageSend = false;
//           }
//         } else {
//           consoleLog('❌ User canceled image picker.');
//         }
//         break;

//       case 'camera':
//         final XFile? photo = await _picker.pickImage(
//           source: ImageSource.camera,
//         );
//         if (photo != null) {
//           addImageOrFileOrMessage(photo.path);
//           selectedImagePathFromCamera.value = photo.path;
//           isRotateFolderAndImageSend = false;
//         } else {
//           consoleLog('❌ User canceled camera.');
//         }
//         break;

//       case 'file':
//         final FilePickerResult? result = await FilePicker.platform.pickFiles(
//           allowMultiple: true,
//         );
//         if (result != null) {
//           selectedFilePaths.value = result.paths.whereType<String>().toList();
//           for (final String path in selectedFilePaths) {
//             addImageOrFileOrMessage(path);
//           }
//           isRotateFolderAndImageSend = false;
//         } else {
//           consoleLog('❌ User canceled file picker.');
//         }
//         break;

//       default:
//         consoleLog('⚠️ Invalid source type: $sourceType');
//     }

//     update();
//   }
//   // end file picker and image picker

//   void toggleisFolderAndImageSend() {
//     isRotateFolderAndImageSend = !isRotateFolderAndImageSend;
//     update();
//   }

//   void startTimer() {
//     if (!hasParticipant) return;

//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       if (secondsLeft > 0) {
//         secondsLeft--;
//         isOpenContainerRange = false;
//         update();
//       } else {
//         timer.cancel();
//         isOpenContainerRange = true;
//         onTimerFinished();
//         update();
//       }
//     });
//   }

//   void stopTimer() {
//     if (_timer != null && _timer!.isActive) {
//       _timer!.cancel();
//     }
//   }

//   void onTimerFinished() {
//     endCall();
//   }

//   Future<void> leaveChannel() async {
//     await endCall();
//   }

//   Future<void> joinAsFirstUser() async {
//     localUserJoined = true;
//     bookings.currentStep = 2;
//     update();
//     bookings.update();
//     await initAgora();
//     Get.toNamed(routeVideoCall);
//   }

//   Future<void> toggleMute() async {
//     isMute = !isMute;
//     await engine.muteAllRemoteAudioStreams(isMute);
//     update();
//   }

//   Future<void> toggleVideoMute() async {
//     if (localUid != null) {
//       isVideoMuted = !isVideoMuted;
//       await engine.muteLocalVideoStream(isVideoMuted);
//       update();
//     }
//   }

//   @override
//   Future<void> onClose() async {
//     engine.release();
//     await _dispose();
//     ChatClient.getInstance.chatManager.removeEventHandler('UNIQUE_HANDLER_ID');
//     ChatClient.getInstance.chatManager.removeMessageEvent('UNIQUE_HANDLER_ID');
//     super.onClose();
//   }

//   Future<void> initAgora() async {
//     await Future.delayed(const Duration(seconds: 2));
//     await <Permission>[Permission.microphone, Permission.camera].request();
//     final bool cameraGranted = await Permission.camera.isGranted;
//     final bool microphoneGranted = await Permission.microphone.isGranted;
//     if (!cameraGranted || !microphoneGranted) {
//       Get.snackbar(
//         'صلاحيات غير متوفرة',
//         'من فضلك، قم بتفعيل صلاحيات الكاميرا والميكروفون في إعدادات الجهاز.',
//       );
//       return;
//     }
//     try {
//       engine = createAgoraRtcEngine();
//       await engine.initialize(
//         RtcEngineContext(
//           appId: appId,
//           channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//         ),
//       );
//       await engine.enableAudioVolumeIndication(
//         interval: 200,
//         smooth: 3,
//         reportVad: true,
//       );
//       engine.registerEventHandler(
//         RtcEngineEventHandler(
//           onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//             localUid = connection.localUid;
//             localUserJoined = true;
//             update();
//           },
//           onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//             this.remoteUid = remoteUid;
//             bookings.currentStep = 2;
//             bookings.update();
//             startTimer();
//             update();
//           },
//           onUserOffline:
//               (
//                 RtcConnection connection,
//                 int remoteUid,
//                 UserOfflineReasonType reason,
//               ) {
//                 if (this.remoteUid == remoteUid) {
//                   this.remoteUid = null;
//                 }
//                 update();
//               },
//           onError: (ErrorCodeType errorCode, String message) {
//             // final String errorMessage = message;
//             if (errorCode == ErrorCodeType.errNoPermission) {
//               // errorMessage =
//               //     'تم رفض الإذن. تأكد من أن لديك الإذن للوصول إلى الكاميرا والميكروفون.';
//             } else if (errorCode == ErrorCodeType.errNetDown) {
//               // errorMessage = 'فشل الاتصال بالشبكة. تحقق من اتصالك بالإنترنت.';
//             }
//             // Get.snackbar('خطأ في الاتصال', errorMessage);
//           },
//           onRejoinChannelSuccess: (RtcConnection connection, int elapsed) {
//             // Get.snackbar('تمت إعادة الاتصال', 'لقد تمت إعادة الاتصال بالقناة.');
//           },
//           onAudioVolumeIndication:
//               (
//                 RtcConnection connection,
//                 List<AudioVolumeInfo> speakers,
//                 int totalVolume,
//                 int elapsed,
//               ) {
//                 for (AudioVolumeInfo speaker in speakers) {
//                   if (speaker.volume != null && speaker.volume! > 10) {
//                     // print('الصوت شغال للمستخدم ${speaker.volume}');
//                   } else {
//                     // print('الصوت هادئ أو ميت للمستخدم ${speaker.uid}');
//                   }
//                 }
//               },

//           onUserMuteVideo: (RtcConnection connection, int uid, bool muted) {
//             if (uid == localUid) {
//               isVideoMuted = muted;
//             } else {
//               isRemoteVideoMuted = muted;
//             }
//             update();
//           },
//         ),
//       );

//       await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//       await engine.enableAudio();
//       await engine.enableVideo();
//       await engine.startPreview();
//       await engine.joinChannel(
//         token: token,
//         channelId: channel,
//         uid: 0,
//         options: const ChannelMediaOptions(
//           clientRoleType: ClientRoleType.clientRoleBroadcaster,
//           channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//           publishCameraTrack: true,
//           publishMicrophoneTrack: true,
//           autoSubscribeVideo: true,
//           autoSubscribeAudio: true,
//         ),
//       );
//       isCallStarted.value = true;
//       update();
//     } catch (e) {
//       isCallStarted.value = false;
//       update();
//       // String errorMessage = 'حدث خطأ غير معروف.';
//       // if (e.toString().contains('Permission denied')) {
//       //   errorMessage =
//       //       'لم يتم منح الصلاحيات المطلوبة للوصول إلى الكاميرا أو الميكروفون.';
//       // } else if (e.toString().contains('Network error')) {
//       //   errorMessage =
//       //       'خطأ في الشبكة. تأكد من أن الاتصال بالإنترنت يعمل بشكل صحيح.';
//       // }
//       // Get.snackbar('خطأ في الاتصال', errorMessage);
//       // debugPrint('Error during initialization: $e');
//     }
//   }

//   Future<void> _dispose() async {
//     await engine.leaveChannel();
//     await engine.stopPreview();
//     await engine.release();
//   }

//   Future<void> endCall() async {
//     localUserJoined = false;

//     if (remoteUid == null || remoteUid == 0) {
//       print('🚪 User is alone in the call, going back');
//       Get.back();
//     } else {
//       isCallEnded.value = false;
//       update();
//     }

//     stopTimer();

//     try {
//       await engine.leaveChannel();
//       await engine.stopPreview();
//       await engine.release();
//     } catch (e) {
//       print('❌ Error leaving channel: $e');
//     }

//     isCallStarted.value = false;
//     isCallEnded.value = true;
//     remoteUid = null;

//     update();
//   }

//   Future<void> retryPermissions() async {
//     await <Permission>[Permission.microphone, Permission.camera].request();
//     if (await Permission.microphone.isGranted &&
//         await Permission.camera.isGranted) {
//       await initAgora();
//     } else {
//       Get.snackbar(
//         'فشل في الحصول على الصلاحيات',
//         'يرجى تمكين الكاميرا والميكروفون من إعدادات الجهاز.',
//       );
//     }
//   }

//   void swapVideoPosition() {
//     isSwapped = !isSwapped;
//     update();
//   }

//   final List<String> symptomImages = <String>[
//     imageNostrils,
//     imageFrontNose,
//     imageLowerEyelid,
//     imageNostrils,
//     imageFrontNose,
//     imageLowerEyelid,
//   ];

//   // data chat
//   List<ChatLog> dummyMessages = [
//     ChatLog(
//       message:
//           "كيف حالك عبدالرحمن متقلقش كل حاجه محلوله باذن الله ولكن قولي بتشتكي من اي ",
//       timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
//       msgId: "1",
//       isSentByMe: true,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message:
//           "كيف حالك عبدالرحمن متقلقش كل حاجه محلوله باذن الله ولكن قولي بتشتكي من اي ",
//       timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
//       msgId: "2",
//       isSentByMe: false,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message:
//           "كيف حالك عبدالرحمن متقلقش كل حاجه محلوله باذن الله ولكن قولي بتشتكي من اي ",
//       timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
//       msgId: "3",
//       isSentByMe: true,
//       isDelivered: false,
//     ),
//     ChatLog(
//       message: "كويس الحمد لله",
//       // filePath: "assets/files/report.pdf", // ملف PDF
//       timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
//       msgId: "4",
//       isSentByMe: false,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message: "تم رفع الصورة المطلوبة.",
//       // filePath: "assets/images/test_image.jpg", // صورة
//       timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//       msgId: "5",
//       isSentByMe: true,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message: "هذا الفيديو مهم للمراجعة.",
//       // filePath: "assets/videos/demo_video.mp4", // فيديو
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       msgId: "6",
//       isSentByMe: false,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message: "هل وصلتك الصورة؟",
//       timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
//       msgId: "7",
//       isSentByMe: true,
//       isDelivered: false,
//     ),
//     ChatLog(
//       message: "",
//       filePath: "assets/files/test.docx", // ملف وورد
//       timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
//       msgId: "8",
//       isSentByMe: false,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message: "شكرًا، وصلت كل الملفات 🙏",
//       timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
//       msgId: "9",
//       isSentByMe: false,
//       isDelivered: true,
//     ),
//     ChatLog(
//       message: "تمام، سأتحدث معك لاحقًا.",
//       timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
//       msgId: "10",
//       isSentByMe: true,
//       isDelivered: true,
//     ),
//   ];
//   // end chat
// }
