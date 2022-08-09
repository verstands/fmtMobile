import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/services/profile.service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();

  static fromJson(p) {}
}

class _ProfileState extends State<Profile> {
  bool loading = false;
  List<dynamic> _profile = [];

  void _profiles() async {
    ApiResponse response = await getprofile();
    if (response.erreur == null) {
      setState(() {
        _profile = response.data as List<dynamic>;
        loading = loading ? !loading : loading;
        print(_profile);
      });
    } else if (response.erreur == unauthorized) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unauthenticated'),
      ));
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
    }
  }

  @override
  void initState() {
    _profiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 100,
            ),
            Text("Rabby Kikwele")
          ],
        )),
      ),
    );
  }
}
