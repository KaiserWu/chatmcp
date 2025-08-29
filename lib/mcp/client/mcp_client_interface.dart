import '../models/json_rpc_message.dart';
import '../models/server.dart';

abstract class McpClient {
  ServerConfig get serverConfig;
  List<Map<String, dynamic>> tools = [];
  List<Map<String, dynamic>> resources = [];
  List<Map<String, dynamic>> prompts = [];

  Future<void> initialize();
  Future<void> dispose();
  Future<JSONRPCMessage> sendMessage(JSONRPCMessage message);
  Future<JSONRPCMessage> sendInitialize();
  Future<JSONRPCMessage> sendPing();
  Future<JSONRPCMessage> sendToolList();
  Future<JSONRPCMessage> sendToolCall({required String name, required Map<String, dynamic> arguments, String? id});
  Future<JSONRPCMessage> sendResourcesList();
  Future<JSONRPCMessage> sendResourcesRead({required String uri, String? id});
  Future<JSONRPCMessage> sendResourcesTemplates();
  Future<JSONRPCMessage> sendResourcesSubscribe({required String uri, String? id});
  Future<JSONRPCMessage> sendPromptsList();
  Future<JSONRPCMessage> sendPromptsGet({required String name, required Map<String, dynamic> arguments, String? id});
}
