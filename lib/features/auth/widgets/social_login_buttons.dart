import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/auth_service.dart';
import '../../home/home_screen.dart';

class SocialLoginButtons extends StatelessWidget {
  void _signInWithGoogle(BuildContext context) async {
    try {
      final user = await AuthService().signInWithGoogle();
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _signInWithGoogle(context),
      icon: Icon(Icons.login),
      label: Text('Sign in with Google'),
    );
  }
}
