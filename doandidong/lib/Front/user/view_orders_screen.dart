import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/order.dart';
import '../../services/db_helper.dart';

class ViewOrdersScreen extends StatefulWidget {
  final User user;

  ViewOrdersScreen({required this.user});

  @override
  _ViewOrdersScreenState createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() async {
    List<Order> orders = await _dbHelper.getOrdersByUser(widget.user.email);
    setState(() {
      _orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Đơn Hàng Của Tôi')),
        body: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            Order order = _orders[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Mã Đơn Hàng: ${order.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Món: ${order.items.map((e) => e.name).join(', ')}'),
                    Text('Tổng: \$${order.total.toStringAsFixed(2)}'),
                    Text('Trạng thái: ${order.status}'),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
