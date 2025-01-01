import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../../../services/db_helper.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'register_screen.dart';
import 'package:flutter2/Front/user/home_screen.dart';
import 'package:flutter2/Front/admin/food_list_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin.");
      return;
    }

    User? user = await _dbHelper.getUser(email, password);
    if (user == null) {
      Fluttertoast.showToast(msg: "Email hoặc mật khẩu không đúng.");
      return;
    }

    Fluttertoast.showToast(msg: "Đăng nhập thành công!");

    if (user.isAdmin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => FoodListScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen(user: user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Đăng Nhập')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              CustomTextField(
                hintText: 'Mật khẩu',
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              CustomButton(text: 'Đăng Nhập', onPressed: _login),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: Text('Chưa có tài khoản? Đăng ký'),
              )
            ],
          ),
        ));
  }
}
