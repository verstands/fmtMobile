import 'dart:convert';

import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/hystorique.model.dart';
import 'package:fmt/models/retrait.model.dart';
import 'package:fmt/screens/accueil.dart';
import 'package:fmt/services/login.service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> codeAgence(String code) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$codeURL/$code'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = Retrait.fromJson(jsonDecode(response.body)['data']);
        break;
      case 403:
        apiResponse.erreur = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.erreur = jsonDecode(response.body)['message'];
        ;
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

//utliser le code
Future<ApiResponse> UtiliserCode(String code) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$UtiliserCodeURL/$code'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.erreur = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.erreur = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.erreur = jsonDecode(response.body)['message'];
        ;
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
