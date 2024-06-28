import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pizzas/providers/order_provider.dart';
import 'package:pizzas/screens/custom_pizza_screen.dart';
//import 'package:pizzas/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'providers/pizza_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/user_provider.dart';
import 'screens/master_screen.dart';
import 'screens/details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/order_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
   //initialLocation: '/signup',

      routes: [
         GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const MasterScreen(),
        ),
        GoRoute(
          path: '/details',
          builder: (context, state) => const DetailsScreen(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ), 
        GoRoute(
          path: '/order',
          builder: (context, state) => const OrderScreen(),
        ),
         GoRoute(
          path: '/custom-pizza',
          builder: (context, state) => const CustomPizzaScreen(),
        ),
      ],
       
   
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PizzaProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),

      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Pizzeria App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
