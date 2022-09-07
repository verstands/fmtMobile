//-----------------requete reussi-------------------
import 'package:flutter/material.dart';

const baseURL = 'http://api-transfert.fastmoneytransfert.com/api';
const loginURL = baseURL + '/loginAgent';
const depotURL = baseURL + '/depot';
const userURL = baseURL + '/retrait';
const deviseURL = baseURL + '/listeDevise';
const payseURL = baseURL + '/listPays';
const codeURL = baseURL + '/codeAgence';
const getcodeURL = baseURL + '/gereteurCode';
const HystoriqueURL = baseURL + '/historiqueAgence';
const profileURL = baseURL + '/profile';
const UtiliserCodeURL = baseURL + '/codeUse';
const PourcentageURL = baseURL + '/pourcentageT';
const countD = baseURL + '/countDepot';
const countR = baseURL + '/countRetrait';
const HystoriqueRURL = baseURL + '/historiqueAgenceR';

//---------------erreur------------------------------
const serverError = "Aucune connexion";
const unauthorized = "Erreur de la base des données ";
const somethingwentwrong = "Quelque chose s'est mal passé, encore une fois";

//input decoration
InputDecoration kinputdecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}
