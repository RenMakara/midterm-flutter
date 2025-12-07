import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _pwdConfirm = TextEditingController();
  final _auth = AuthService();
  String? _error;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _pwd, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
          TextField(controller: _pwdConfirm, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password')),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () async {
              final user = UserModel(email: _email.text.trim(), password: _pwd.text);
              final result = await _auth.register(user, _pwdConfirm.text);
              if (result != null) {
                setState(() { _error = result; });
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text('Register'),
          )
        ]),
      ),
    );
  }
}