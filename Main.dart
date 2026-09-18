import 'package:flutter/material.dart';

void main() {
  runApp(SellKaroApp());
}

class SellKaroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Cars & Bikes', 'icon': Icons.directions_car, 'color': Colors.blue},
    {'title': 'Properties', 'icon': Icons.home, 'color': Colors.green},
    {'title': 'Jobs', 'icon': Icons.work, 'color': Colors.orange},
    {'title': 'Mobiles', 'icon': Icons.phone_android, 'color': Colors.deepPurple},
    {'title': 'Fashion', 'icon': Icons.checkroom, 'color': Colors.pink},
    {'title': 'Books & Sports', 'icon': Icons.sports_basketball, 'color': Colors.amber},
    {'title': 'Electronics', 'icon': Icons.devices, 'color': Colors.indigo},
    {'title': 'Commercial Vehicles', 'icon': Icons.local_shipping, 'color': Colors.cyan},
    {'title': 'Furniture', 'icon': Icons.weekend, 'color': Colors.brown},
    {'title': 'Pets', 'icon': Icons.pets, 'color': Colors.deepOrange},
    {'title': 'Services', 'icon': Icons.miscellaneous_services, 'color': Colors.teal},
    {'title': 'Business Buy/Sell', 'icon': Icons.storefront, 'color': Colors.redAccent},
    {'title': 'Matrimony (Rishte)', 'icon': Icons.favorite, 'color': Colors.pinkAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SellKaro — Smart Selling ke sath Rishte & Bhavishya'),
        backgroundColor: Colors.orange.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Kya dhoond rahe hain? (Car, Job, Rishta...)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Sabhi Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categories[index]['icon'],
                            size: 34,
                            color: categories[index]['color'],
                          ),
                          SizedBox(height: 6),
                          Text(
                            categories[index]['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
