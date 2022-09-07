import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/hystorique.model.dart';
import 'package:fmt/screens/login.dart';
import 'package:fmt/services/hystorique.service.dart';

class DepotScreen extends StatefulWidget {
  const DepotScreen({Key? key}) : super(key: key);

  @override
  State<DepotScreen> createState() => _DepotScreenState();
}

class _DepotScreenState extends State<DepotScreen> {
  List<dynamic> _hysto = [];
  bool _loadingHy = true;

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 0),
    );
  }

  void initState() {
    super.initState();
    _hystorique();
  }

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.erreur}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF000000),
          title: Text('Historique Depot'),
        ),
        body: _loadingHy
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Hystorique hystoriques = _hysto[index];
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(columns: [
                        DataColumn(label: Text('Pays')),
                        DataColumn(label: Text('Nom exp')),
                        DataColumn(label: Text('Nom benef')),
                        DataColumn(label: Text('Tel')),
                        DataColumn(label: Text('Montant')),
                        DataColumn(label: Text('Devise')),
                      ], rows: [
                        DataRow(selected: true, cells: [
                          DataCell(Text("${hystoriques.nom}")),
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
              ));
  }
}
