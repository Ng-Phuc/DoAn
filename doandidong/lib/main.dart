import 'package:flutter/material.dart';
import 'package:flutter2/Front/auth/login_screen.dart';
import 'package:flutter2/Front/auth/register_screen.dart';
import 'package:flutter2/Front/admin/food_list_screen.dart';
import 'package:flutter2/Front/admin/order_list_screen.dart';
import 'package:flutter2/Front/user/home_screen.dart';
import 'package:flutter2/Front/user/view_orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Định nghĩa route
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng Dụng Đặt Món',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/admin/food_list': (context) => FoodListScreen(),
        '/admin/orders': (context) => OrderListScreen(),
        // Thêm các route khác nếu cần
      },
    );
  }
}
