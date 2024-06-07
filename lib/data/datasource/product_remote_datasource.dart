import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ticketapp/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ticketapp/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts(
      {int page = 1, int limit = 10}) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/product?page=$page&limit=$limit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data?.token}',
      },
    );

    Map<String, dynamic> resultRes = json.decode(response.body);

    // response.statusCode

    if (response.statusCode == 200) {
      // print(response.body);
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return Left(resultRes['message']);
    }
  }
}
