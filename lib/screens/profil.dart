import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';

import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/profile.model.dart';
import 'package:fmt/services/login.service.dart';
import 'package:fmt/services/profile.service.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();

  static fromJson(p) {}
}

class _ProfileState extends State<Profile> {
  bool loading = true;
  String? destory;
  Profil? pro;
  final GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  TextEditingController txtnom = TextEditingController();
  TextEditingController txtprenom = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  void _profi() async {
    final response = await getprofile();
    if (response.erreur == null) {
      setState(() {
        pro = response.data as Profil;
        txtemail.text = pro!.email ?? "";
        txtprenom.text = pro!.prenom ?? "";
        txtnom.text = pro!.nom ?? "";
        loading = false;
      });
    } else if (response.erreur == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _profi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false)
                    });
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 100,
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : Form(
                    key: formkey2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: txtnom,
                            validator: (val) =>
                                val!.isEmpty ? 'Nom vide' : null,
                            decoration: InputDecoration(
                                labelText: 'Nom',
                                contentPadding: EdgeInsets.all(10),
                                enabled: false,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black))),
                          ),
                          const Divider(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: txtprenom,
                            validator: (val) =>
                                val!.isEmpty ? 'prenom vide' : null,
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: 'Prenom',
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black))),
                          ),
                          const Divider(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: txtemail,
                            validator: (val) =>
                                val!.isEmpty ? 'email vide' : null,
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black))),
                          ),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
