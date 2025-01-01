import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../services/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() async {
    List<Order> orders = await _dbHelper.getAllOrders();
    setState(() {
      _orders = orders;
    });
  }

  void _updateStatus(Order order, String status) async {
    await _dbHelper.updateOrderStatus(order.id!, status);
    Fluttertoast.showToast(msg: "Cập nhật trạng thái thành công.");
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Danh Sách Đơn Hàng'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                })
          ],
        ),
        body: ListView.builder(
          itemCount: _orders.length,
          itemBuilder: (context, index) {
            Order order = _orders[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Email: ${order.userEmail}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Món: ${order.items.map((e) => e.name).join(', ')}'),
                    Text('Tổng: \$${order.total.toStringAsFixed(2)}'),
                    Text('Trạng thái: ${order.status}'),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    _updateStatus(order, value);
                  },
                  itemBuilder: (BuildContext context) {
                    return ['Pending', 'Processing', 'Completed']
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            );
          },
        ));
  }
}
