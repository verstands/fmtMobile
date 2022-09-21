import 'package:flutter/material.dart';
import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/login.model.dart';
import 'package:fmt/screens/accueil.dart';
import 'package:fmt/screens/home.dart';
import 'package:fmt/screens/load.dart';
import 'package:fmt/services/login.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', response.Ttoken ?? '');
      print(response.Ttoken);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Accueil()), (route) => false);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
    }
  }

  void _saveAndRedirectToHome(Agence access_token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', access_token.access_token ?? '');
    print(pref.getString('toekn'));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Accueil()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectez-vous'),
        backgroundColor: const Color(0xFF000000),
      ),
      body: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.all(32),
            children: [
              Center(
                child: Icon(
                  Icons.person,
                  size: 90,
                ),
              ),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                  validator: (val) => val!.isEmpty ? 'champs email vide' : null,
                  decoration: kinputdecoration('Email')),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: txtpassword,
                validator: (val) =>
                    val!.isEmpty ? 'champs mot de password vide' : null,
                decoration: kinputdecoration('Password'),
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      height: 85,
                      child: TextButton(
                        child: Text(
                          "Se connecter",
                          style: TextStyle(color: Colors.orange),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            padding: MaterialStateProperty.resolveWith(
                                (states) =>
                                    EdgeInsets.symmetric(vertical: 10))),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              _loginUser();
                            });
                          }
                        },
                      ),
                    ),
            ],
          )),
    );
  }
}
