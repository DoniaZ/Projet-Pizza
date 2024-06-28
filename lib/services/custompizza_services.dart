import 'package:pizzas/services/api_services.dart';
import '../models/custompizza.dart';

class CustomPizzaService {
  final ApiService _apiService = ApiService();

  Future<List<CustomPizza>> fetchCustomPizzas() async {
    final response = await _apiService.getRequest('/items/custompizzas');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => CustomPizza.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load custom pizzas');
    }
  }

  Future<CustomPizza> fetchCustomPizzaById(String id) async {
    final response = await _apiService.getRequest('/items/custompizzas/$id');
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return CustomPizza.fromJson(data);
    } else {
      throw Exception('Failed to load custom pizza');
    }
  }

  Future<CustomPizza> createCustomPizza(CustomPizza customPizza) async {
    final response = await _apiService.postRequest(
        '/items/custompizzas', customPizza.toJson());
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return CustomPizza.fromJson(data);
    } else {
      throw Exception('Failed to create custom pizza');
    }
  }

  Future<CustomPizza> updateCustomPizza(
      String id, CustomPizza customPizza) async {
    final response = await _apiService.putRequest(
        '/items/custompizzas/$id', customPizza.toJson());
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return CustomPizza.fromJson(data);
    } else {
      throw Exception('Failed to update custom pizza');
    }
  }

  Future<void> deleteCustomPizza(String id) async {
    final response = await _apiService.deleteRequest('/items/custompizzas/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete custom pizza');
    }
  }
}
