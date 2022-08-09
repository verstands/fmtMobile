import 'dart:convert';

import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/hystorique.model.dart';
import 'package:fmt/models/retrait.model.dart';
import 'package:fmt/screens/accueil.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> codeAgence(String code) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    //String token = await getToken();
    String token = "131|NU3YjhgPSY7B70yRjioynkvkquiAbmqcv9yttUfm";

    final response = await http.get(Uri.parse('$codeURL/$code'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => Retrait.fromJson(p))
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
