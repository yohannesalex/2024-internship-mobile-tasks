import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constant.dart';
import '../../../../core/error/exeptions.dart';
import '../model/get_me_response_model.dart';
import '../model/login_response_model.dart';
import '../model/signup_response_model.dart';
import '../model/token_taker_model.dart';

abstract class AuthRemoteDataSource {
  Future<GetMeResponseModel> getMe(String token);
  Future<void> signUp(SignupResponseModel user);
  Future<TokenTakerModel> login(LoginResponseModel user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<GetMeResponseModel> getMe(String token) async {
    final response = await client.get(
      Uri.parse('${Uris.baseUrl}/users/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return (GetMeResponseModel(name: data['name']));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TokenTakerModel> login(LoginResponseModel user) async {
    final jsonBody = {
      'email': user.email,
      'password': user.password,
    };

    final response = await client.post(
      Uri.parse('${Uris.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );
    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['data'];
      return (TokenTakerModel.fromJson(token));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> signUp(SignupResponseModel user) async {
    final jsonBody = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
    };

    final response = await client.post(
      Uri.parse('${Uris.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );
    if (response.statusCode != 201) {
      throw ServerException();
    }
  }
}
