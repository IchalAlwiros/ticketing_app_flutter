import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ticketapp/core/constants/variables.dart';
import 'package:flutter_ticketapp/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ticketapp/data/models/request/login_request_model.dart';
import 'package:flutter_ticketapp/data/models/response/login_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  Future<Either<dynamic, LoginResponseModel>> login(
      LoginRequestModel data) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: data.toJson(),
    );

    Map<String, dynamic> resultRes = json.decode(response.body);

    if (response.statusCode == 200) {
      AuthLocalDatasource()
          .saveAuthData(LoginResponseModel.fromJson(response.body));

      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return Left(resultRes['message']);
    }
  }

  //logout
  Future<Either<String, dynamic>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();

    // AuthLocalDatasource().removeAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data?.token}',
      },
    );

    Map<String, dynamic> resultRes = json.decode(response.body);

    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData();
      return Right(resultRes['message']);
    } else {
      return Left(resultRes['message']);
    }
  }
}
