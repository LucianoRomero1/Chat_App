import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/users_response.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final uri = Uri.parse("${Environment.apiUrl}/users");
      final res = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': AuthService.getToken().toString()
      });

      final usersResponse = usersResponseFromJson(res.body);

      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
