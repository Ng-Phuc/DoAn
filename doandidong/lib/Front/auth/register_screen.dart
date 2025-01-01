import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../services/db_helper.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();

  void _register() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng điền đầy đủ thông tin.");
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.showToast(msg: "Mật khẩu không trùng khớp.");
      return;
    }

    // Kiểm tra email đã tồn tại chưa
    User? existingUser = await _dbHelper.getUserByEmail(email);
    if (existingUser != null) {
      Fluttertoast.showToast(msg: "Email đã được sử dụng.");
      return;
    }

    User newUser = User(
      username: username,
      email: email,
      password: password,
      isAdmin: false, // Mặc định người dùng không phải admin
    );

    await _dbHelper.insertUser(newUser);
    Fluttertoast.showToast(msg: "Đăng ký thành công!");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Đăng Ký')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Tên người dùng',
                controller: _usernameController,
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              CustomTextField(
                hintText: 'Xác nhận mật khẩu',
                controller: _confirmPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 20),
              CustomButton(text: 'Đăng Ký', onPressed: _register),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text('Đã có tài khoản? Đăng nhập'),
              )
            ],
          ),
        ));
  }
}
