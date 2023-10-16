import 'package:appbanhang/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    TextEditingController emailText = TextEditingController();
    TextEditingController passText = TextEditingController();
    void handleSubmit() {
      final email = emailText.text.toString();
      final pass = passText.text.toString();
      if (email.isNotEmpty && pass.isNotEmpty) {
        Provider.of<AuthProvider>(context, listen: false).login(email, pass);
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: emailText,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passText,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 5 / 10,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      handleSubmit();
                    },
                    child: const Text('Login')))
          ],
        ),
      ),
    );
  }
}
