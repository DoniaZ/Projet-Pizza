import 'package:dio/dio.dart';
import '../models/user.dart';

class UserServices {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pizzas.shrp.dev'));

  Future<Response?> signUp(User user) async {
    try {
      final response = await _dio.post('/users', data: user.toJson());
      return response;
    } catch (e) {
      //print('Erreur lors de la création du compte: $e');
      return null;
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['access_token'];
    } catch (e) {
      //print('Erreur lors de l\'authentification: $e');
      return null;
    }
  }

  Future<Response?> placeOrder(String token, List<Map<String, dynamic>> orderlines) async {
    try {
      final response = await _dio.post(
        '/items/orders',
        data: {'orderlines': orderlines},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } catch (e) {
     // print('Erreur lors du passage de commande: $e');
      return null;
    }
  }
}