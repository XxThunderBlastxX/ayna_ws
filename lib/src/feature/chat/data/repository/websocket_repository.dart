import 'package:web_socket_channel/web_socket_channel.dart';

import '../interface/websocket_interface.dart';

class WebsocketRepository extends IWebsocket {
  final WebSocketChannel _channel;

  WebsocketRepository(WebSocketChannel channel) : _channel = channel;

  @override
  Future<WebsocketRepository> connect() async {
    final ws = WebsocketRepository(WebSocketChannel.connect(
      Uri.parse("wss://echo.websocket.org/"),
    ));
    await ws._channel.ready;
    return ws;
  }

  @override
  Future<void> close() {
    return _channel.sink.close();
  }

  @override
  void send(String message) {
    _channel.sink.add(message);
  }

  Stream<String> get stream => _channel.stream.cast();
}
