//-----------------requete reussi-------------------
import 'package:flutter/material.dart';

const baseURL = 'http://192.168.1.103:82/api';
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

//---------------erreur------------------------------
const serverError = "Erreur de la connexion";
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
