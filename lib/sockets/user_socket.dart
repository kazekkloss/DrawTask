import 'package:socket_io_client/socket_io_client.dart';

import 'sockets.dart';

class UserSocket {
  final _socketClient = SocketConnect.instance.socket!;
  Socket get socketConnect => _socketClient;

}
