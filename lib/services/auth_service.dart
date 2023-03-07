import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authenticating = false;
  final _storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {'email': email, 'password': password};

    final uri = Uri.parse("${Environment.apiUrl}/login");

    final res = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    authenticating = false;
    print(res.body);
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    authenticating = true;

    final data = {'name': name, 'email': email, 'password': password};

    final uri = Uri.parse("${Environment.apiUrl}/login/register");

    final res = await http.post(uri,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    authenticating = false;
    print(res.body);
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(res.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async{
    //Tengo el token guardado aca
    final token  = await this._storage.read(key: 'token');

    final uri = Uri.parse("${Environment.apiUrl}/login/renew");
    
    //Puedo poner x-token o authenticate
    final res = await http.get(uri, headers: {'Content-Type': 'application/json', 'x-token': token.toString()});

    authenticating = false;
    print(res.body);
    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      this.logout();

      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
