import 'package:chat_app/models/messages_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/global/environment.dart';

class ChatService with ChangeNotifier {
  late User userTo;

  Future<List<Message>> getChat(String userID) async {
    final uri = Uri.parse("${Environment.apiUrl}/messages/$userID");

    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': AuthService.getToken().toString()
    });

    final messagesResponse = messagesResponseFromJson(res.body);

    return messagesResponse.messages;
  }
}
