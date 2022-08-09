//-----------------requete reussi-------------------
import 'package:flutter/material.dart';

const baseURL = 'https://api-transfert.fastmoneytransfert.com/api';
const loginURL = baseURL + '/loginAgent';
const depotURL = baseURL + '/depot';
const userURL = baseURL + '/retrait';
const deviseURL = baseURL + '/listeDevise';
const payseURL = baseURL + '/listPays';
const codeURL = baseURL + '/codeAgence';
const getcodeURL = baseURL + '/gereteurCode';
const HystoriqueURL = baseURL + '/historiqueAgence';
const profileURL = baseURL + '/profile';

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
