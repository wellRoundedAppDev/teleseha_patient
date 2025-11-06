import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection connection;
  bool isConnected = false;

  Future<void> initConnection(String hubUrl, String accessToken) async {
    // إعداد الاتصال مع التوكن
    connection = HubConnectionBuilder()
        .withUrl(
          hubUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () async => accessToken,
          ),
        )
        .withAutomaticReconnect()
        .build();

    // استقبال الأحداث القادمة من السيرفر
    connection.on('CallInvite', (List<Object?>? args) {
      print('📩 Incoming call invite: $args');
      // هنا استدعي دالة داخل VideoCallController مثلاً
    });

    connection.on('CallAccepted', (List<Object?>? args) {
      print('📞 Call accepted: $args');
      // استدعي joinAgora()
    });

    connection.on('CallEnded', (List<Object?>? args) {
      print('❌ Call ended: $args');
      // استدعي endCall()
    });

    await connection.start();
    isConnected = true;
    print('✅ SignalR Connected!');
  }

  Future<void> sendInvite(
    String targetUserId,
    String room,
    String callerName,
  ) async {
    await connection.invoke(
      'InviteUser',
      args: <Object>[targetUserId, room, callerName],
    );
  }

  Future<void> acceptCall(String room) async {
    await connection.invoke('AcceptCall', args: <Object>[room]);
  }

  Future<void> endCall(String room) async {
    await connection.invoke('EndCall', args: <Object>[room]);
  }

  Future<void> dispose() async {
    await connection.stop();
    isConnected = false;
  }
}
