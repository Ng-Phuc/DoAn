import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../models/user.dart';
import '../../models/food_item.dart';
import '../../services/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  final User user;
  final List<FoodItem> cartItems;
  final double total;

  CheckoutScreen(
      {required this.user, required this.cartItems, required this.total});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final DBHelper _dbHelper = DBHelper();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  void _placeOrder() async {
    String address = _addressController.text.trim();
    String phone = _phoneController.text.trim();

    if (address.isEmpty || phone.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng điền địa chỉ và số điện thoại.");
      return;
    }

    // Tạo đơn hàng
    var uuid = Uuid();
    Order order = Order(
      userEmail: widget.user.email,
      items: widget.cartItems,
      total: widget.total,
      status: 'Pending',
    );

    await _dbHelper.insertOrder(order);
    Fluttertoast.showToast(msg: "Đặt hàng thành công!");

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Thanh Toán')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: 'Địa chỉ giao hàng',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: 'Số điện thoại',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _placeOrder, child: Text('Đặt Hàng')),
            ],
          ),
        ));
  }
}
