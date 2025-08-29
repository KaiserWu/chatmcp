import 'package:chatmcp/mcp/client/basic_client.dart';
import 'package:chatmcp/mcp/models/json_rpc_message.dart';
import 'package:chatmcp/mcp/models/server.dart';
import 'package:logging/logging.dart';

import '../client/mcp_client_interface.dart';
import 'memory_server.dart';

class InMemoryClient extends BasicClient implements McpClient {
  final MemoryServer server;

  InMemoryClient({required this.server});

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}

  @override
  Future<JSONRPCMessage> sendInitialize() async {
    Logger.root.fine('InMemoryClient sendInitialize');
    return sendMessage(JSONRPCMessage(id: 'init-1', method: 'initialize'));
  }

  @override
  Future<JSONRPCMessage> sendMessage(JSONRPCMessage message) async {
    final result = server.onmessage(message);
    return result;
  }

  @override
  Future<JSONRPCMessage> sendToolCall({required String name, required Map<String, dynamic> arguments, String? id}) async {
    return sendMessage(JSONRPCMessage(id: id, method: 'tools/call', params: {'name': name, 'arguments': arguments}));
  }

  @override
  ServerConfig get serverConfig => throw UnimplementedError();
}
