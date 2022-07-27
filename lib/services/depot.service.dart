import 'dart:convert';

import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/depot.model.dart';
import 'package:fmt/models/devise.model.dart';
import 'package:fmt/services/login.service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> DepotUser(
    String num_envoi,
    String montant_envoi,
    String devise,
    String expediteur,
    String beneficiaire,
    String phone,
    String agence,
    String pays) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(depotURL),
      headers: {'Accept': 'application/json', 'Autorization': 'Bearer $token'},
      body: {
        'num_envoi': num_envoi,
        'montant_envoi': montant_envoi,
        'id_devise': devise,
        'expediteur': expediteur,
        'beneficiaire': beneficiaire,
        'phone_exp': phone,
        'id_agence': agence,
        'id_pays': pays
      },
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

Future<ApiResponse> getPays() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      apiResponse.data = Devise.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      apiResponse.erreur = unauthorized;
    } else {
      apiResponse.erreur = somethingwentwrong;
    }
  } catch (e) {
    apiResponse.erreur = serverError;
  }
  return apiResponse;
}
