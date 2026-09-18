import 'package:flutter/material.dart';
import 'login.dart';
import 'matrimony.dart';
import 'sell_business.dart';
import 'sell_vehicle.dart';
import 'sell_property.dart';
import 'sell_furniture_appliances.dart';

void main() {
  runApp(SellKaroApp());
}

class SellKaroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SellKaro - Pan-India Super App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/matrimony': (context) => MatrimonyScreen(),
        '/business': (context) => SellBusinessScreen(),
        '/vehicle': (context) => SellVehicleScreen(),
        '/property': (context) => SellPropertyScreen(),
        '/furniture': (context) => SellFurnitureAppliancesScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SellKaro - Bharat ka Super App'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'स्मार्ट सेलिंग के साथ अपने रिश्ते और भविष्य भी बनाएं',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Sabhi Categories (All-India Coverage)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            
            // Grid of Categories linking to respective screens
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildCategoryCard(
                  context,
                  'Matrimony (Rishte)',
                  Icons.favorite,
                  Colors.pink,
                  '/matrimony',
                ),
                _buildCategoryCard(
                  context,
                  'Cars & Vehicles',
                  Icons.directions_car,
                  Colors.blue,
                  '/vehicle',
                ),
                _buildCategoryCard(
                  context,
                  'Property & Rent',
                  Icons.home,
                  Colors.green,
                  '/property',
                ),
                _buildCategoryCard(
                  context,
                  'Business & Machines',
                  Icons.storefront,
                  Colors.red,
                  '/business',
                ),
                _buildCategoryCard(
                  context,
                  'Furniture & Appliances',
                  Icons.weekend,
                  Colors.teal,
                  '/furniture',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String routeName,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
