import 'dart:convert';

import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/code.model.dart';
import 'package:fmt/models/depot.model.dart';
import 'package:fmt/models/devise.model.dart';
import 'package:fmt/models/hystorique.model.dart';
import 'package:fmt/models/pays.model.dart';
import 'package:fmt/services/login.service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> depotUser(
    String code,
    String montant_envoi,
    String id_devise,
    String expediteur,
    String beneficiaire,
    String phone_exp,
    String id_pays,
    String id_ag) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    //String token = await getToken();
    String token = await getToken();

    final response = await http.post(
      Uri.parse(depotURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'code': code,
        'montant_envoi': montant_envoi,
        'id_devise': id_devise,
        'expediteur': expediteur,
        'beneficiaire': beneficiaire,
        'phone_exp': phone_exp,
        'id_pays': id_pays,
        'id_ag': id_ag
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.erreur = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.erreur = unauthorized;
        break;
      default:
        apiResponse.erreur = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.erreur = serverError;
  }
  return apiResponse;
}

//Les devises

//getcode
Future<ApiResponse> getCode() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.get(Uri.parse(getcodeURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['code'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['code'];
        apiResponse.erreur = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.erreur = unauthorized;
        break;
      default:
        apiResponse.erreur = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.erreur = serverError;
  }
  return apiResponse;
}

//pourcentage
Future<ApiResponse> getPourcentage(String montant) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$PourcentageURL/$montant'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.erreur = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.erreur = unauthorized;
        break;
      default:
        apiResponse.erreur = somethingwentwrong;
        break;
    }
  } catch (e) {
    apiResponse.erreur = serverError;
  }
  return apiResponse;
}
