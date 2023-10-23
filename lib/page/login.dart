import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _csrfToken = "";

  @override
  void initState() {
    super.initState();
    fetchCsrf();
  }

  Future<void> fetchCsrf() async {
    String url = '${dotenv.get('DEV_URL')}/api-auth/login/';
    try {
      final response = await http.get(Uri.parse(url));
      final cookieHeader = response.headers['set-cookie'];
      final cookie = cookieHeader?.split(';').first;
      print(response.body);
      if (cookie != null) {
        final parts = cookie.split('=');
        if (parts.length == 2) {
          _csrfToken = parts[1];
          print(_csrfToken);
        }
      }
    } catch (error) {
      print(error);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("Username"),
        TextField(controller: _usernameController),
        Text("Password"),
        TextField(controller: _passwordController),
      ]),
    );
  }
}