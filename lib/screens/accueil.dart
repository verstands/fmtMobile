import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  //pour le depot
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtNum_envoie = TextEditingController();
  TextEditingController txtExp = TextEditingController();
  TextEditingController txtBenefice = TextEditingController();
  TextEditingController txtTel = TextEditingController();
  TextEditingController txtAgence = TextEditingController();
  TextEditingController txtPays = TextEditingController();
  TextEditingController txtMontant = TextEditingController();
  TextEditingController txtDevise = TextEditingController();
  //fin de depot

  @override
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/logo/dollars.png",
              ),
            ),
            title: const Text(
              'Nombre des entrées',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: const Text(
              '120',
              style: TextStyle(color: Colors.red),
            ),
            trailing:
                IconButton(onPressed: null, icon: Icon(Icons.arrow_forward)),
          ),
          Divider(height: 10),
          // nombre des sortie
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/logo/users.png",
              ),
            ),
            title: const Text(
              'Nombre des sorties',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: const Text('200'),
            trailing:
                IconButton(onPressed: null, icon: Icon(Icons.arrow_forward)),
          ),
        ]),
      ),
      Container(
        padding: EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Entrez le code',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black))),
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                height: 85,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: const Color(0xFF000000)),
                  onPressed: () {},
                  child: const Text('Verifiez'),
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
                  controller: txtNum_envoie,
                  decoration: InputDecoration(
                      labelText: 'Numero d\'envoi',
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
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue),
                        padding: MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.symmetric(vertical: 10))),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {}
                    },
                  ),
                )
              ],
            )),
      ),
      Text(
        'Index 3: Settings',
        style: optionStyle,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('FMT'),
        backgroundColor: const Color(0xFF000000),
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
