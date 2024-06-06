import 'package:get_it/get_it.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../feature/chat/data/repository/websocket_repository.dart';
import '../cache/cache.dart';
import 'supabase_service.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  await _initSupabase();
  await initializeCache();
  _repositories();
}

Future<void> _initSupabase() async {
  await SupabaseService.init();
  sl.registerSingleton<SupabaseService>(SupabaseService());
}

void _repositories() {
  sl.registerLazySingleton<WebsocketRepository>(
    () => WebsocketRepository(
      WebSocketChannel.connect(
        Uri.parse("wss://echo.websocket.org/"),
      ),
    ),
  );
}
