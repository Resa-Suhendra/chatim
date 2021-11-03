import 'package:chatim/services/auth_service.dart';
import 'package:chatim/services/shared_prefs.dart';
import 'package:chatim/ui/home_page.dart';
import 'package:chatim/ui/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("Login Firebase"),
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

    Widget loginButton = ElevatedButton(
      onPressed: () async {
        SignInSignUpResult data = await AuthServices.signIn(
            emailController.text, passwordController.text);

        debugPrint("=> Hasil Login : " + data.message.toString());

        if (data.personModel != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));

          Shared.savePersonSession(data.personModel!);
          Shared.setLoginSession(true);
        } else {}
      },
      child: Text("Login"),
    );

    Widget spacer = const SizedBox(
      height: 20,
    );

    Widget registerButton = GestureDetector(
      child: Text("Belum punya akun? Daftar disni."),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterPage()));
      },
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailField,
              spacer,
              passwordField,
              spacer,
              loginButton,
              spacer,
              registerButton
            ],
          ),
        ),
      ),
    );
  }
}
