import 'package:drawtask/config/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketConnect {
  io.Socket? socket;
  static SocketConnect? _instance;

  SocketConnect._internal() {
    socket = io.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket!.connect();
  }

  static SocketConnect get instance {
    _instance ??= SocketConnect._internal();
    return _instance!;
  }
}
