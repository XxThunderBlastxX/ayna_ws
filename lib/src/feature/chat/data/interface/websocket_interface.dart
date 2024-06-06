import 'package:web_socket_channel/web_socket_channel.dart';

abstract class IWebsocket {
  Future<WebSocketChannel> connect();

  Future<void> close();

  void send(String message);
}
