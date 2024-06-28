import 'package:pizzas/services/api_services.dart';
import '../models/order.dart';

class OrderService {
  final ApiService _apiService = ApiService();

  Future<List<Order>> fetchOrders() async {
    final response = await _apiService.getRequest('/orders');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> fetchOrderById(String id) async {
    final response = await _apiService.getRequest('/orders/$id');
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return Order.fromJson(data);
    } else {
      throw Exception('Failed to load order');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await _apiService.postRequest('/orders', order.toJson());
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return Order.fromJson(data);
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<Order> updateOrder(String id, Order order) async {
    final response =
        await _apiService.putRequest('/orders/$id', order.toJson());
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return Order.fromJson(data);
    } else {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder(String id) async {
    final response = await _apiService.deleteRequest('/orders/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
