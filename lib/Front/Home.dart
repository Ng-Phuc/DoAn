  import 'package:flutter/material.dart';
  import 'Cart.dart';
  import 'Login.dart';
  import 'Register.dart';

  class FoodShopHomePage extends StatefulWidget {
    @override
    _FoodShopHomePageState createState() => _FoodShopHomePageState();
  }

  class _FoodShopHomePageState extends State<FoodShopHomePage> {
    List<Map<String, dynamic>> cart = [];

    void addToCart(String productName, String price) {
      setState(() {
        cart.add({"name": productName, "price": price});
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.shopping_bag),
              SizedBox(width: 8),
              Text('Shop PT'),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple), // Tím đậm
                ),
                child: Text(
                  'Đăng Nhập',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple.shade200), // Tím nhạt
                ),
                child: Text(
                  'Đăng Ký',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Highlight Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://th.bing.com/th/id/R.f413b97b3a5e3b44297b9edc7f8cb0be?rik=1TFDXPPQopMx%2fQ&pid=ImgRaw&r=0',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '10 món ngon giảm giá hôm nay',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text('Nhận ngay'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Carousel Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://www.willflyforfood.net/wp-content/uploads/2022/11/pakistani-food-gol-gappa.jpg'),
                          radius: 25,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://www.willflyforfood.net/wp-content/uploads/2022/11/pakistani-food-gol-gappa.jpg'),
                          radius: 25,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://www.willflyforfood.net/wp-content/uploads/2022/11/pakistani-food-gol-gappa.jpg'),
                          radius: 25,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://www.willflyforfood.net/wp-content/uploads/2022/11/pakistani-food-gol-gappa.jpg'),
                          radius: 25,
                        ),
                      ],
                    ),
                  ),

                  // Suggested Items Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Món Ngon Nên Thử!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...List.generate(4, (index) {
                    String productName = 'Món ăn ${index + 1}';
                    String productPrice = '15,000 VND';
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                            'https://www.chefspencil.com/wp-content/uploads/Kokoda.jpg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(productName),
                          subtitle: Row(
                            children: [
                              Text(
                                productPrice,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '20,000 VND',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              addToCart(productName, productPrice);
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartDetailsPage(cart: cart)),
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Xem giỏ hàng (${cart.length})'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

