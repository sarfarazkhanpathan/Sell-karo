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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SellKaro — Smart Selling & Rishte'),
        backgroundColor: Colors.orange.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Yahan location helper khulega
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Location Chunein'),
                  content: Text('Gujarat ke sabhi shehar auto-populated hain!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Theek hai'),
                    ),
                  ],
                ),
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
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sabhi Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Gossip Room direct access
                  },
                  icon: Icon(Icons.chat, color: Colors.purple),
                  label: Text('Gossip Room', style: TextStyle(color: Colors.purple)),
                ),
              ],
            ),
            SizedBox(height: 8),
            
            // Categories Grid with Navigation
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
                        // Yahan click hone par alag-alag screens par bhejenge
                        String route = cat['route'];
                        String msg = '${cat['title']} section jald khulega!';
                        
                        if (route == 'gossip') {
                          msg = 'Gossip & Chat Room open ho raha hai!';
                        } else if (route == 'matrimony') {
                          msg = 'Matrimony Rishte section open ho raha hai!';
                        } else if (route == 'vehicle') {
                          msg = 'Vehicle Ad form open ho raha hai!';
                        } else if (route == 'property') {
                          msg = 'Property Ad form open ho raha hai!';
                        } else if (route == 'jobs') {
                          msg = 'Jobs listing open ho rahi hai!';
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(msg), duration: Duration(seconds: 1)),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cat['icon'],
                            size: 34,
                            color: cat['color'],
                          ),
                          SizedBox(height: 6),
                          Text(
                            cat['title'],
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
