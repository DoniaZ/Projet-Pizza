import 'package:dio/dio.dart';
import 'package:pizzas/models/ingredient.dart';
import '../models/pizza.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pizzas.shrp.dev'));

  Future<List<Pizza>> getPizzas() async {
    final response = await _dio.get('/items/pizzas');
    return (response.data['data'] as List)
        .map((pizza) => Pizza.fromJson(pizza))
        .toList();
  }
  Future<Response> getRequest(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Ingredient>> fetchIngredients() async {
    final response = await _dio.get('/items/pizzas_ingredients');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Ingredient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load ingredients');
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to post data');
    }
  }

  Future<Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception('Failed to update data');
    }
  }

  Future<Response> deleteRequest(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      throw Exception('Failed to delete data');
    }
  }







}
