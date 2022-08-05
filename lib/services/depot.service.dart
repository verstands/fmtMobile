import 'dart:convert';

import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/depot.model.dart';
import 'package:fmt/models/devise.model.dart';
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
    String id_pays) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    //String token = await getToken();
    String token = "144|DyOrGf0sVE8ffEipGOoFcygByehErZaahm7MbXRR";

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
        'id_pays': id_pays
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

//Les pays
Future<ApiResponse> getPays() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    //String token = await getToken();
    String token = "139|yoTlUUeUOknSqRyrGcurGJa4kmilKOdYEtooCIz6";

    final response = await http.get(Uri.parse(payseURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message']
            .map((p) => Pays.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
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

//Les devises
Future<ApiResponse> getDevise() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    //String token = await getToken();
    String token = "139|yoTlUUeUOknSqRyrGcurGJa4kmilKOdYEtooCIz6";

    final response = await http.get(Uri.parse(deviseURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message']
            .map((p) => Devise.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
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

//code
Future<ApiResponse> getCode() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    //String token = await getToken();
    String token = "139|yoTlUUeUOknSqRyrGcurGJa4kmilKOdYEtooCIz6";

    final response = await http.get(Uri.parse(codeURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['code']
            .map((p) => Depot.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        print(apiResponse.data);
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
