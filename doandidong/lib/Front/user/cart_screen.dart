import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/food_item.dart';
import '../../services/db_helper.dart';
import '../user/checkout_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class CartScreen extends StatefulWidget {
  final User user;
  final List<FoodItem> cartItems;

  CartScreen({required this.user, required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DBHelper _dbHelper = DBHelper();
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    double total = 0.0;
    widget.cartItems.forEach((item) {
      total += item.price;
    });
    setState(() {
      _total = total;
    });
  }

  void _checkout() async {
    if (widget.cartItems.isEmpty) {
      Fluttertoast.showToast(msg: "Giỏ hàng trống.");
      return;
    }

    bool? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CheckoutScreen(
              user: widget.user,
              cartItems: widget.cartItems,
              total: _total,
            )));

    if (result == true) {
      Fluttertoast.showToast(msg: "Đặt hàng thành công!");
      Navigator.pop(context, true);
    }
  }

  void _removeFromCart(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
      _calculateTotal();
    });
    Fluttertoast.showToast(msg: "Đã xóa món ăn khỏi giỏ hàng.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Giỏ Hàng')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  FoodItem item = widget.cartItems[index];
                  return ListTile(
                    leading: item.image.isNotEmpty
                        ? Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.fastfood, size: 50),
                    title: Text(item.name),
                    subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeFromCart(index),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng: \$${_total.toStringAsFixed(2)}',
                      style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: _checkout, child: Text('Thanh Toán'))
                ],
              ),
            )
          ],
        ));
  }
}
