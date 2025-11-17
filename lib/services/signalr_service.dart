import 'package:signalr_netcore/signalr_client.dart';

import '../general_exports.dart';

class SignalRService {
  late HubConnection connection;
  bool isConnected = false;

  Future<void> initConnection(String hubUrl, String accessToken) async {
    connection = HubConnectionBuilder()
        .withUrl(
          hubUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () async => accessToken,
          ),
        )
        .withAutomaticReconnect()
        .build();

    connection.on('ReceiveAppointmentUpdates', (List<Object?>? args) {
      consoleLog('📩 Received: $args');
    });

    await connection.start();
    isConnected = true;
    consoleLog('✅ Connected: ${connection.state}');
    consoleLog('✅ SignalR Connected!');
    dispose();
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
