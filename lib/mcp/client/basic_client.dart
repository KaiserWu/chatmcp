import 'package:chatmcp/mcp/client/mcp_client_interface.dart';
import 'package:chatmcp/mcp/models/json_rpc_message.dart';

abstract class BasicClient extends McpClient {
  @override
  Future<JSONRPCMessage> sendPing() async {
    return sendMessage(JSONRPCMessage(id: 'ping-1', method: 'ping'));
  }

  @override
  Future<JSONRPCMessage> sendToolList() async {
    final response = await sendMessage(JSONRPCMessage(id: 'tool-list-1', method: 'tools/list'));
    final toolsList = response.toJson()['result']['tools'] as List<dynamic>;
    tools.addAll(toolsList.cast<Map<String, dynamic>>());
    return response;
  }

  @override
  Future<JSONRPCMessage> sendToolCall({required String name, required Map<String, dynamic> arguments, String? id}) async {
    final message = JSONRPCMessage(
      method: 'tools/call',
      params: {
        'name': name,
        'arguments': arguments,
        '_meta': {'progressToken': 0},
      },
      id: id ?? 'tool-call-${DateTime.now().millisecondsSinceEpoch}',
    );

    return sendMessage(message);
  }

  @override
  Future<JSONRPCMessage> sendResourcesList() async {
    final response = await sendMessage(JSONRPCMessage(id: 'resource-list-1', method: 'resources/list'));
    final resourcesList = response.toJson()['result']['resources'] as List<dynamic>;
    resources.addAll(resourcesList.cast<Map<String, dynamic>>());
    return response;
  }

  @override
  Future<JSONRPCMessage> sendResourcesRead({required String uri, String? id}) async {
      final message = JSONRPCMessage(
      method: 'resources/read',
      params: {
        'uri': uri,
      },
      id: id ?? 'resource-read-${DateTime.now().millisecondsSinceEpoch}',
    );

    return sendMessage(message);
  }

  @override
  Future<JSONRPCMessage> sendResourcesTemplates() async {
    return sendMessage(JSONRPCMessage(id: 'resource-templates-1', method: 'resources/templates/list'));
  }

  @override
  Future<JSONRPCMessage> sendResourcesSubscribe({required String uri, String? id}) async {
    return sendMessage(JSONRPCMessage(method: 'resources/subscribe', params: {'uri': uri}, id: id ?? 'resource-subscribe-${DateTime.now().millisecondsSinceEpoch}'));
  }

  @override
  Future<JSONRPCMessage> sendPromptsList() async {
    final response = await sendMessage(JSONRPCMessage(id: 'prompts-list-1', method: 'prompts/list'));
    final promptsList = response.toJson()['result']['prompts'] as List<dynamic>;
    prompts.addAll(promptsList.cast<Map<String, dynamic>>());
    return response;
  }

  @override
  Future<JSONRPCMessage> sendPromptsGet({required String name, required Map<String, dynamic> arguments, String? id}) async {
    return sendMessage(JSONRPCMessage(method: 'prompts/get', params: {'name': name, 'arguments': arguments}, id: id ?? 'prompts-get-${DateTime.now().millisecondsSinceEpoch}'));
  }
}