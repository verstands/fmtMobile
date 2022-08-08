import 'dart:developer';
import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/code.model.dart';
import 'package:fmt/models/hystorique.model.dart';
import 'package:fmt/screens/login.dart';
import 'package:fmt/screens/profil.dart';
import 'package:fmt/services/depot.service.dart';
import 'package:fmt/services/hystorique.service.dart';
import 'package:fmt/services/retrait.service.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  bool loading = false;
  bool _loadingHy = false;
  List<dynamic> _hysto = [];
  List<dynamic> _pays = [];
  String dropdownValue = 'One';
  List<String> itmes = ['item1', 'items2'];
  String? selectItem = 'item1';
  //historique
  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 0),
    );
  }

  void _hystorique() async {
    ApiResponse response = await gethistorique();
    if (response.erreur == null) {
      setState(() {
        _hysto = response.data as List<dynamic>;
        _loadingHy = _loadingHy ? !_loadingHy : _loadingHy;
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
      setState(() {
        loading = false;
      });
    }
  }

  //fin historique

  //retrait

  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  TextEditingController txtverifi = TextEditingController();

  void _agenceCode() async {
    ApiResponse response = await codeAgence(txtverifi.text);
    if (response.erreur == null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Argent envoyé avec success'),
      ));
    } else if (response.erreur == unauthorized) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unauthenticatedaaaaaaaaaaaa'),
      ));
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

  //pour le depot
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtNumEnvoie = TextEditingController();
  TextEditingController txtExp = TextEditingController();
  TextEditingController txtBenefice = TextEditingController();
  TextEditingController txtTel = TextEditingController();
  TextEditingController txtPays = TextEditingController();
  TextEditingController txtMontant = TextEditingController();
  TextEditingController txtDevise = TextEditingController();
  //fin de depot
  //depot

  void _createDepot() async {
    ApiResponse response = await depotUser(
        txtNumEnvoie.text,
        txtMontant.text,
        txtDevise.text,
        txtExp.text,
        txtBenefice.text,
        txtTel.text,
        txtPays.text);

    if (response.erreur == null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Argent envoyé avec success'),
      ));
    } else if (response.erreur == unauthorized) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unauthenticated'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
      setState(() {
        loading = !loading;
      });
    }
  }

  //fin depot
  String? code;
  Future<void> _retrieveCode() async {
    ApiResponse response = await getCode();
    if (response.erreur == null) {
      setState(() {
        txtNumEnvoie.text = response.data.toString();
      });
    } else if (response.erreur == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
    }
  }

  @override
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _hystorique();
      _retrieveCode();
      _selectedIndex = index;
    });
  }

  String? value;
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "Retrait",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      "30",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "Retrait",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      "30",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formkey1,
          child: ListView(
            children: [
              TextFormField(
                controller: txtverifi,
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty ? 'champ vide' : null,
                decoration: InputDecoration(
                    labelText: 'Entrez le code',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
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
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            padding: MaterialStateProperty.resolveWith(
                                (states) =>
                                    EdgeInsets.symmetric(vertical: 10))),
                        onPressed: () {
                          if (formkey1.currentState!.validate()) {
                            /*showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("FMT"),
                                content: Text(
                                    'Voulez-vous faire un retrait \n code : $txtverifi'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Non")),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          loading = true;
                                          _useCOde();
                                        });
                                      },
                                      child: Text("Oui"))
                                ],
                              ),
                            );*/
                            setState(() {
                              loading = true;
                              _agenceCode();
                            });
                          }
                        },
                        child: const Text(
                          'Verifiez',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: formkey,
            child: ListView(
              children: [
                const Text("Faire un depot"),
                const Divider(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (val) => val!.isEmpty ? 'Nom d\'envoi' : null,
                  controller: txtNumEnvoie,
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Code',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: txtExp,
                  validator: (val) =>
                      val!.isEmpty ? 'Nom de expediteur vide' : null,
                  decoration: InputDecoration(
                      labelText: 'Nom de expediteur',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: txtBenefice,
                  validator: (val) =>
                      val!.isEmpty ? 'Nom de beneficiaire vide' : null,
                  decoration: InputDecoration(
                      labelText: 'Nom de beneficiaire',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: txtTel,
                  validator: (val) =>
                      val!.isEmpty ? 'Telephone expediteur vide' : null,
                  decoration: InputDecoration(
                      labelText: 'Telephone expediteur',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  controller: txtMontant,
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Montant' : null,
                  decoration: InputDecoration(
                      labelText: 'Montant',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  controller: txtDevise,
                  keyboardType: TextInputType.text,
                  validator: (val) => val!.isEmpty ? 'Devise' : null,
                  decoration: InputDecoration(
                      labelText: 'Devise',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  controller: txtPays,
                  keyboardType: TextInputType.text,
                  validator: (val) => val!.isEmpty ? 'Pays vide' : null,
                  decoration: InputDecoration(
                      labelText: 'Pays',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  height: 85,
                  child: TextButton(
                    child: Text(
                      "Envoyez",
                      style: TextStyle(color: Colors.orange),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        padding: MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.symmetric(vertical: 10))),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("FMT"),
                            content: Text("Voulez-vous faire une transaction?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Non")),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      loading = !loading;
                                    });
                                    _createDepot();
                                  },
                                  child: Text("Oui"))
                            ],
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            )),
      ),
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Hystorique hystoriques = _hysto[index];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(columns: [
                DataColumn(label: Text('Pays')),
                DataColumn(label: Text('Agence')),
                DataColumn(label: Text('Nom exp')),
                DataColumn(label: Text('Nom benef')),
                DataColumn(label: Text('Tel')),
                DataColumn(label: Text('Montant')),
                DataColumn(label: Text('Devise')),
              ], rows: [
                DataRow(selected: true, cells: [
                  DataCell(Text("${hystoriques.nom}")),
                  DataCell(Text('${hystoriques.nomAgence}')),
                  DataCell(Text('${hystoriques.expediteur}')),
                  DataCell(Text('${hystoriques.beneficiaire}')),
                  DataCell(Text('${hystoriques.phoneExp}')),
                  DataCell(Text('${hystoriques.montantEnvoi}')),
                  DataCell(Text('${hystoriques.intitule}')),
                ]),
              ]),
            ),
          );
        },
        itemCount: _hysto.length,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('FMT'),
        backgroundColor: const Color(0xFF000000),
        actions: [
          SizedBox(
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: Icon(Icons.person)),
          ),
        ],
      ),
      backgroundColor: Colors.white30,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Color(0xFF000000),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'Retrait',
            backgroundColor: Color(0xFF000000),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Depot',
            backgroundColor: Color(0xFF000000),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_toggle_off_rounded,
            ),
            label: 'Historique',
            backgroundColor: Color(0xFF000000),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
