import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('SellKaro - Super App'),
        backgroundColor: Colors.indigo.shade800,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أهلاً وسهلاً! Welcome,',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4),
            Text(
              user?.email ?? 'All-India Classifieds User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 16),
            
            // विज्ञापन देखने के लिए डायरेक्ट बटन
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/view_ads');
                },
                icon: Icon(Icons.list_alt),
                label: Text('View All Posted Ads (सभी विज्ञापन देखें)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade700,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 16),
            Text(
              'अपनी कैटेगरी चुनें और विज्ञापन पोस्ट करें:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildCategoryCard(
                    context,
                    'Vehicles (वाहन)',
                    Icons.directions_car,
                    Colors.orange,
                    '/sell_vehicle',
                  ),
                  _buildCategoryCard(
                    context,
                    'Properties (प्रॉपर्टी)',
                    Icons.home,
                    Colors.blue,
                    '/sell_property',
                  ),
                  _buildCategoryCard(
                    context,
                    'Matrimony (रिश्ते)',
                    Icons.favorite,
                    Colors.pink,
                    '/matrimony',
                  ),
                  _buildCategoryCard(
                    context,
                    'Business & Machines',
                    Icons.business,
                    Colors.red,
                    '/sell_business',
                  ),
                  _buildCategoryCard(
                    context,
                    'Furniture & Appliances',
                    Icons.chair,
                    Colors.teal,
                    '/sell_furniture',
                  ),
                ],
              ),
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          try {
            Navigator.pushNamed(context, routeName);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('मार्ग (Route) जल्द सेट किया जाएगा: $routeName')),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 12),
              Text(
                title,
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
      ),
    );
  }
}
