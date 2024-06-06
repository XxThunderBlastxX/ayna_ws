import 'package:web_socket_channel/web_socket_channel.dart';

import '../repository/websocket_repository.dart';

abstract class IWebsocket {
  Future<WebsocketRepository> connect();

  Future<void> close();

  void send(String message);
}
