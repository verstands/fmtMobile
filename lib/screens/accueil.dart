import 'dart:developer';
import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmt/constant.dart';
import 'package:fmt/models/CountR.model.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/code.model.dart';
import 'package:fmt/models/hystorique.model.dart';
import 'package:fmt/models/retrait.model.dart';
import 'package:fmt/screens/depot.dart';
import 'package:fmt/screens/login.dart';
import 'package:fmt/screens/profil.dart';
import 'package:fmt/screens/retrait.dart';
import 'package:fmt/services/depot.service.dart';
import 'package:fmt/services/hystorique.service.dart';
import 'package:fmt/services/profile.service.dart';
import 'package:fmt/services/retrait.service.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  bool loading = false;
  bool loading_depot = true;
  bool _loadingHy = true;
  List<dynamic> _hysto = [];
  List _paysG = [];
  List _deviseD = [];
  String? _mystate;
  List<dynamic> _agentcode = [];
  String? dropdownValue;
  String? dropdownValue1;
  List<String> itmes = ['item1', 'items2'];
  String? selectItem = 'item1';
  //historique

  //variable retrait
  int? id;
  String? code;
  String? montantEnvoi;
  String? idDevise;
  String? expediteur;
  String? beneficiaire;
  String? phoneExp;
  String? idPays;
  String? createdAt;
  String? updatedAt;
  String? dates;
  int? status;
  int? idAg;
  String? idUser;
  Retrait? RT;

  //variable depot
  String? txtMontanttext,
      txtDevisetext,
      txtExptext,
      txtBeneficetext,
      txtTeltext,
      txtPaystext;

  //count
  String? countDe;
  String? countRe;
  //refresh
  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 0),
    );
  }

  void _countD() async {
    final response = await getcountD();
    if (response.erreur == null) {
      setState(() {
        countDe = response.data.toString();
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

  void _countR() async {
    final response = await getcountR();
    if (response.erreur == null) {
      setState(() {
        countRe = response.data.toString();
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

  //hystorique
  void _hystorique() async {
    ApiResponse response = await gethistorique();
    if (response.erreur == null) {
      setState(() {
        _hysto = response.data as List<dynamic>;
        _loadingHy = false;
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

  //pays
  void _payss() async {
    ApiResponse response = await getPays();
    if (response.erreur == null) {
      setState(() {
        _paysG = response.data as List;
      });
    } else if (response.erreur == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pays'),
      ));
      setState(() {
        loading = false;
      });
    }
  }

  void _devise() async {
    ApiResponse response = await getDevise();
    if (response.erreur == null) {
      setState(() {
        _deviseD = response.data as List;
      });
    } else if (response.erreur == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('devise'),
      ));
      setState(() {
        loading = false;
      });
    }
  }
  //fin pays

  //Utiliser le code
  void _utiliserCode() async {
    ApiResponse response = await UtiliserCode(code!);
    if (response.erreur == null) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.erreur}'),
        ));
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

  //retrait
  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  TextEditingController txtverifi = TextEditingController();

  void _agenceCode() async {
    ApiResponse response = await codeAgence(txtverifi.text);
    if (response.erreur == null) {
      setState(() {
        RT = response.data as Retrait;
        code = RT!.code ?? "";
        montantEnvoi = RT!.montantEnvoi ?? "";
        idDevise = RT!.intitule ?? "";
        expediteur = RT!.expediteur ?? "";
        beneficiaire = RT!.beneficiaire ?? "";
        phoneExp = RT!.phoneExp ?? "";
        idPays = RT!.nom ?? "";
        dates = RT!.dates ?? "";
        idAg = (RT!.idAg ?? "") as int?;
        loading = false;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("FMT"),
            content: Text(
                'Voulez-vous faire un retrait? \n\n Code : $code \n Nom expediteur : $expediteur \n Nom beneficiare : $beneficiaire \n Telephone : $phoneExp \n Montant : $montantEnvoi \n Devise : $idDevise \n Pays : $idPays \n Date : $dates '),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Non",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _utiliserCode();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("Oui"))
            ],
          ),
        );
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

  //pour le depot
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtNumEnvoie = TextEditingController();
  TextEditingController txtExp = TextEditingController();
  TextEditingController txtBenefice = TextEditingController();
  TextEditingController txtTel = TextEditingController();
  TextEditingController txtPays = TextEditingController();
  TextEditingController txtMontant = TextEditingController();
  TextEditingController txtDevise = TextEditingController();
  TextEditingController txtPour = TextEditingController();
  //fin de depot

  //pourcentage

  void _pour(var montant) async {
    ApiResponse response = await getPourcentage(montant);
    if (response.erreur == null) {
      setState(() {
        txtPour.text = response.data.toString();
      });
    } else if (response.erreur == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {}
  }

  //depot
  void _createDepot() async {
    ApiResponse response = await depotUser(
        txtNumEnvoie.text,
        txtMontant.text,
        dropdownValue1.toString(),
        txtExp.text,
        txtBenefice.text,
        txtTel.text,
        dropdownValue.toString(),
        txtPour.text);

    if (response.erreur == null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Argent envoyé avec success'),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Accueil()));
    } else if (response.erreur == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
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

  @override
  void initState() {
    super.initState();
    _payss();
    _devise();
    _countR();
    _countD();
    _hystorique();
  }

  void _onItemTapped(int index) {
    setState(() {
      _hystorique();
      _retrieveCode();
      _countR();
      _countD();
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
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
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
                      "$countRe",
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
                    color: Colors.grey),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "Depot",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      "$countDe",
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
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            padding: MaterialStateProperty.resolveWith(
                                (states) =>
                                    EdgeInsets.symmetric(vertical: 10))),
                        onPressed: () {
                          if (formkey1.currentState!.validate()) {
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
                  validator: (val) => val!.isEmpty ? 'code d\'envoi' : null,
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
                      val!.isEmpty ? 'Noms de expediteur vide' : null,
                  decoration: InputDecoration(
                      labelText: 'Noms de expediteur',
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
                      val!.isEmpty ? 'Noms de beneficiaire vide' : null,
                  decoration: InputDecoration(
                      labelText: 'Noms de beneficiaire',
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
                  onChanged: (String? newval) {
                    _pour(newval);
                  },
                ),
                const Divider(
                  height: 10,
                ),
                TextFormField(
                  controller: txtPour,
                  keyboardType: TextInputType.number,
                  enabled: false,
                  validator: (val) => val!.isEmpty ? 'Pourcentage' : null,
                  decoration: InputDecoration(
                      labelText: 'Pourcentage',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                ),
                const Divider(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    items: _deviseD.map((select) {
                      return new DropdownMenuItem(
                          value: select['id'].toString(),
                          child: new Text(select['intitule'].toString()));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        dropdownValue1 = newVal.toString();
                      });
                    },
                    value: dropdownValue1,
                    hint: Text("Selectionnez une devise"),
                  ),
                ),
                const Divider(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    items: _paysG.map((select) {
                      return new DropdownMenuItem(
                          value: select['id'].toString(),
                          child: new Text(select['nom'].toString()));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        dropdownValue = newVal.toString();
                      });
                    },
                    value: dropdownValue,
                    hint: Text("Selectionnez un pays"),
                  ),
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
                            content:
                                Text("Voulez-vous faire une transaction? "),
                            actions: [
                              loading_depot
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(''),
                              Divider(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Non",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          loading_depot = false;
                                          _createDepot();
                                        });
                                      },
                                      child: Text("Oui")),
                                ],
                              ),
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
      ListView(
        children: [
          Divider(
            height: 20,
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
            ),
            title: const Text(
              'Depot',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DepotScreen()));
              },
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DepotScreen()));
            },
          ),
          Divider(
            height: 20,
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
            ),
            title: const Text(
              'Retrait',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Retrait_Screen()));
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Retrait_Screen()));
            },
          ),
        ],
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
