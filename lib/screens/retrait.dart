import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/hystoriqueR.dart';
import 'package:fmt/models/retrait.model.dart';
import 'package:fmt/screens/login.dart';
import 'package:fmt/services/hystorique.service.dart';

class Retrait_Screen extends StatefulWidget {
  const Retrait_Screen({Key? key}) : super(key: key);

  @override
  State<Retrait_Screen> createState() => _Retrait_ScreenState();
}

class _Retrait_ScreenState extends State<Retrait_Screen> {
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
    ApiResponse response = await gethistoriqueR();
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
        title: Text('Historique Retrait'),
      ),
      body: _loadingHy
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                hystoriqueR hystoriques = _hysto[index];
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
                        DataCell(Text('${hystoriques.phone}')),
                        DataCell(Text('${hystoriques.montantEnvoi}')),
                        DataCell(Text('${hystoriques.intitule}')),
                      ]),
                    ]),
                  ),
                );
              },
              itemCount: _hysto.length,
            ),
    );
  }
}
