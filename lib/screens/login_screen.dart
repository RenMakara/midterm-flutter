import 'package:flutter/material.dart';
import '../services/auth_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _auth = AuthService();
  String? _error;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _pwdCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
          if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final user = await _auth.login(_emailCtrl.text.trim(), _pwdCtrl.text);
              if (user == null) {
                setState(() { _error = 'Invalid credentials'; });
              } else {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
            child: const Text('Login'),
          ),
          TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: const Text('Register'))
        ]),
      ),
    );
  }
}