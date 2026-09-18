import 'package:flutter/material.dart';
import 'matrimony.dart';
import 'jobs.dart';
import 'gossip_chat.dart';
import 'location_helper.dart';
import 'sell_vehicle.dart';
import 'sell_property.dart';
import 'sell_business.dart';
import 'digital_shop.dart';

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
    {'title': 'Cars & Bikes', 'icon': Icons.directions_car, 'color': Colors.blue, 'route': 'vehicle'},
    {'title': 'Properties', 'icon': Icons.home, 'color': Colors.green, 'route': 'property'},
    {'title': 'Jobs', 'icon': Icons.work, 'color': Colors.orange, 'route': 'jobs'},
    {'title': 'Mobiles', 'icon': Icons.phone_android, 'color': Colors.deepPurple, 'route': 'mobiles'},
    {'title': 'Fashion', 'icon': Icons.checkroom, 'color': Colors.pink, 'route': 'fashion'},
    {'title': 'Books & Sports', 'icon': Icons.sports_basketball, 'color': Colors.amber.shade800, 'route': 'books'},
    {'title': 'Electronics', 'icon': Icons.devices, 'color': Colors.indigo, 'route': 'electronics'},
    {'title': 'Commercial Vehicles', 'icon': Icons.local_shipping, 'color': Colors.cyan, 'route': 'commercial'},
    {'title': 'Furniture', 'icon': Icons.weekend, 'color': Colors.brown, 'route': 'furniture'},
    {'title': 'Pets', 'icon': Icons.pets, 'color': Colors.deepOrange, 'route': 'pets'},
    {'title': 'Services', 'icon': Icons.miscellaneous_services, 'color': Colors.teal, 'route': 'services'},
    {'title': 'Business Buy/Sell', 'icon': Icons.storefront, 'color': Colors.redAccent, 'route': 'business'},
    {'title': 'Matrimony (Rishte)', 'icon': Icons.favorite, 'color': Colors.pinkAccent, 'route': 'matrimony'},
    {'title': 'Gupshup & Gossip', 'icon': Icons.chat_bubble_outline, 'color': Colors.purple, 'route': 'gossip'},
    {'title': 'Digital Shop (Store)', 'icon': Icons.shopping_bag, 'color': Colors.deepOrange.shade800, 'route': 'digital_shop'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SellKaro - Smart Selling & Rishte'),
        backgroundColor: Colors.orange.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Location Helper / All-India Search khulega
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllIndiaLocationScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
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
            SizedBox(height: 10),
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
                  final cat = categories[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Yahan routing handle ki ja rahi hai
                        String route = cat['route'];
                        if (route == 'vehicle') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SellVehicleScreen()));
                        } else if (route == 'property') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SellPropertyScreen()));
                        } else if (route == 'jobs') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => JobsScreen()));
                        } else if (route == 'matrimony') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MatrimonyScreen()));
                        } else if (route == 'gossip') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GossipChatScreen()));
                        } else if (route == 'business') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SellBusinessScreen()));
                        } else if (route == 'digital_shop') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DigitalShopScreen()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${cat['title']} ka page jald a raha hai!')),
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'], size: 40, color: cat['color']),
                          SizedBox(height: 8),
                          Text(
                            cat['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
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
