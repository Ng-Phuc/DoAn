import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../models/food_item.dart';
import '../../services/db_helper.dart';
import '../user/cart_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<FoodItem> _foodItems = [];
  List<FoodItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }

  // Lấy danh sách món ăn từ cơ sở dữ liệu
  void _fetchFoodItems() async {
    try {
      List<FoodItem> items = await _dbHelper.getFoodItems();
      setState(() {
        _foodItems = items;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Không thể tải danh sách món ăn: $e");
    }
  }

  // Thêm món ăn vào giỏ hàng
  void _addToCart(FoodItem item) {
    setState(() {
      _cartItems.add(item);
    });
    Fluttertoast.showToast(msg: "${item.name} đã được thêm vào giỏ hàng.");
  }

  // Điều hướng đến giỏ hàng
  void _navigateToCart() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          user: widget.user,
          cartItems: _cartItems,
        ),
      ),
    );

    // Xử lý nếu cần xóa giỏ hàng sau khi quay lại
    if (result == true) {
      setState(() {
        _cartItems.clear();
      });
    }
  }

  // Đăng xuất
  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chào ${widget.user.username}'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _navigateToCart,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _foodItems.isEmpty
          ? Center(
        child: Text(
          'Hiện chưa có món ăn nào.',
          style: TextStyle(fontSize: 18.0),
        ),
      )
          : ListView.builder(
        itemCount: _foodItems.length,
        itemBuilder: (BuildContext context, int index) {
          FoodItem item = _foodItems[index];
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: ListTile(
              leading: item.image.isNotEmpty
                  ? Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover)
                  : Icon(Icons.fastfood, size: 50),
              title: Text(item.name),
              subtitle: Text('${item.price.toStringAsFixed(2)} VNĐ'),
              trailing: ElevatedButton(
                onPressed: () => _addToCart(item),
                child: Text('Thêm vào giỏ'),
              ),
            ),
          );
        },
      ),
    );
  }
}
