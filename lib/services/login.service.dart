import 'dart:convert';
import 'package:fmt/constant.dart';
import 'package:fmt/models/api_response.dart';
import 'package:fmt/models/login.model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> loginUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(loginURL),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = Agence.fromJson(jsonDecode(response.body));
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(
            'token', jsonDecode(response.body)['access_token'] ?? '');
        pref.commit();
        apiResponse.Ttoken = pref.getString('token');
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.erreur = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.erreur = jsonDecode(response.body)['message'];
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

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      apiResponse.data = Agence.fromJson(jsonDecode(response.body));
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

//creation de token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//envoie l'udentifiant de user
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('id') ?? 0;
}

//Se deconnester
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}
