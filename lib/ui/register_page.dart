import 'package:chatim/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Register Firebase"),
    );

    Widget nameField = TextFormField(
      controller: nameController,
      decoration: InputDecoration(label: Text("Name")),
    );

    Widget emailField = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(label: Text("Email")),
    );

    Widget passwordField = TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(label: Text("Password")),
    );

    Widget registerButton = ElevatedButton(
      onPressed: () async {
        SignInSignUpResult data = await AuthServices.signUp(
          nameController.text,
          emailController.text,
          passwordController.text,
        );

        debugPrint("=> Hasil Register : " + data.message.toString());
      },
      child: Text("Register"),
    );

    Widget spacer = const SizedBox(
      height: 20,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nameField,
                spacer,
                emailField,
                spacer,
                passwordField,
                spacer,
                registerButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
