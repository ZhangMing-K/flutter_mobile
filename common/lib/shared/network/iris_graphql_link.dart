import 'package:graphql/client.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:websocket/websocket.dart' as ws;

// import 'package:websocket/websocket.dart' as _ws;

/// Custom version of [WebSocketLink] that connects with the given headers
class IrisWSLink implements Link {
  /// Creates a new [WebSocketLink] instance with the specified config.
  IrisWSLink(
    this.url, {
    required this.config, // = const SocketClientConfig(),
    this.headers,
    required this.getToken,
  });

  final String url;
  final SocketClientConfig config;

  Map<String, dynamic>? headers;
  Function? getToken;
  // cannot be final because we're changing the instance upon a header change.
  SocketClient? socketClient;

  @override
  Stream<Response> request(Request request, [forward]) async* {
    if (socketClient == null) {
      connectOrReconnect();
    }

    yield* socketClient!.subscribe(request, true);
  }

  Iterable<String> protocols = const <String>[
    'graphql-ws',
  ];

  /// Connects or reconnects to the server with the specified headers.
  void connectOrReconnect() {
    if (getToken != null) {
      headers ??= {};
      headers!['authorization'] = getToken?.call();
    }

    socketClient?.dispose();
    socketClient = SocketClient(
      url,
      config: config,
      connect: (url, protocols) => IOWebSocketChannel.connect(
        this.url,
        protocols: this.protocols,
        headers: headers,
      ),
    );
  }

  /// Disposes the underlying socket client explicitly. Only use this, if you want to disconnect from
  /// the current server in favour of another one. If that's the case, create a new [WebSocketLink] instance.
  @override
  Future<void> dispose() async {
    await socketClient?.dispose();
    socketClient = null;
  }

  @override
  Link concat(Link next) {
    throw UnimplementedError();
  }

  @override
  Link route(route) {
    throw UnimplementedError();
  }

  @override
  Link split(bool Function(Request request) test, Link left, [Link? right]) {
    throw UnimplementedError();
  }
}
