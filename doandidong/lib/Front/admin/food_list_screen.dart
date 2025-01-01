import 'package:flutter/material.dart';
import '../../models/food_item.dart';
import '../../services/db_helper.dart';
import 'add_edit_food_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<FoodItem> _foodItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFoodItems();
  }

  void _fetchFoodItems() async {
    List<FoodItem> items = await _dbHelper.getFoodItems();
    setState(() {
      _foodItems = items;
    });
  }

  void _deleteFoodItem(int id) async {
    await _dbHelper.deleteFoodItem(id);
    Fluttertoast.showToast(msg: "Đã xóa món ăn.");
    _fetchFoodItems();
  }

  void _navigateToAddEdit({FoodItem? item}) async {
    bool? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AddEditFoodScreen(
              foodItem: item,
            )));
    if (result == true) {
      _fetchFoodItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quản Lý Món Ăn'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _navigateToAddEdit(),
        ),
        body: ListView.builder(
          itemCount: _foodItems.length,
          itemBuilder: (context, index) {
            FoodItem item = _foodItems[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: item.image.isNotEmpty
                    ? Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover)
                    : Icon(Icons.fastfood, size: 50),
                title: Text(item.name),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _navigateToAddEdit(item: item),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteFoodItem(item.id!),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
