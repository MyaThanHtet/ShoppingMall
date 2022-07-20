import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopping_mall/model/ProductModel.dart';
import 'package:shopping_mall/model/login_response_model.dart';
import 'package:http/http.dart' as http;

class ApiControl {
  var dio = Dio();

  static Future<List<Product>> fetchArticle() async {
    Response response = await Dio().get('https://fakestoreapi.com/products');
    return (response.data as List).map((x) => Product.fromJson(x)).toList();
  }

  static Future<List<Product>> fetchArticleByCategorie(
      String categoriename) async {
    Response response = await Dio()
        .get('https://fakestoreapi.com/products/category/$categoriename');
    return (response.data as List).map((x) => Product.fromJson(x)).toList();
  }

  static Future<Product> fetchArticleByID(int aricle_ID) async {
    Response response =
        await Dio().get('https://fakestoreapi.com/products/$aricle_ID');
    Product _product = Product.fromJson(response.data);
    return _product;
  }

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://fakestoreapi.com/auth/login";
    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson(), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception("Failed to load data");
    }
  }
}
