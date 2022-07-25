import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fmt/screens/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await loginUser(txtEmail.text, txtpassword.text);
    if (response.erreur == null) {
      _saveAndRedirectToHome(response.data as Agence);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
    }
  }

  void _saveAndRedirectToHome(Agence agence) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', agence.token ?? '');
    await pref.setInt('id', agence.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => accueil()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF000000),
      ),
      body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              const Image(image: AssetImage('assets/logo/user.PNG')),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                  validator: (val) => val!.isEmpty ? 'Email invalid' : null,
                  decoration: kinputdecoration('Email')),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: txtpassword,
                validator: (val) =>
                    val!.isEmpty ? 'mot de password invalid' : null,
                decoration: kinputdecoration('Password'),
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      height: 85,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: const Color(0xFF000000)),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              _loginUser();
                            });
                          }
                        },
                        child: const Text('Se connecter'),
                      ),
                    ),
            ],
          )),
    );
  }
}
