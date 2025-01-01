import 'package:flutter/material.dart';
import '../../models/food_item.dart';
import '../../services/db_helper.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter2/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEditFoodScreen extends StatefulWidget {
  final FoodItem? foodItem;

  AddEditFoodScreen({this.foodItem});

  @override
  _AddEditFoodScreenState createState() => _AddEditFoodScreenState();
}

class _AddEditFoodScreenState extends State<AddEditFoodScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    if (widget.foodItem != null) {
      _nameController.text = widget.foodItem!.name;
      _descriptionController.text = widget.foodItem!.description;
      _priceController.text = widget.foodItem!.price.toString();
      _imageController.text = widget.foodItem!.image;
    }
  }

  void _saveFoodItem() async {
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    String priceText = _priceController.text.trim();
    String image = _imageController.text.trim();

    if (name.isEmpty || priceText.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng điền tên và giá.");
      return;
    }

    double? price = double.tryParse(priceText);
    if (price == null) {
      Fluttertoast.showToast(msg: "Giá không hợp lệ.");
      return;
    }

    FoodItem item = FoodItem(
      id: widget.foodItem?.id,
      name: name,
      description: description,
      price: price,
      image: image,
    );

    if (widget.foodItem == null) {
      await _dbHelper.insertFoodItem(item);
      Fluttertoast.showToast(msg: "Thêm món ăn thành công!");
    } else {
      await _dbHelper.updateFoodItem(item);
      Fluttertoast.showToast(msg: "Cập nhật món ăn thành công!");
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.foodItem == null ? 'Thêm Món Ăn' : 'Sửa Món Ăn'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Tên món ăn',
                  controller: _nameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Mô tả',
                  controller: _descriptionController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Giá',
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: 'URL Hình Ảnh',
                  controller: _imageController,
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 20),
                CustomButton(
                    text: widget.foodItem == null ? 'Thêm' : 'Cập Nhật',
                    onPressed: _saveFoodItem),
              ],
            ),
          ),
        ));
  }
}
