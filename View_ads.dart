import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAdsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Posted Ads (सभी विज्ञापन)'),
        backgroundColor: Colors.indigo.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // यहाँ हम Firebase के अलग-अलग कलेक्शंस से डेटा देख सकते हैं, उदाहरण के लिए vehicles
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'कोई विज्ञापन उपलब्ध नहीं है!',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            );
          }

          final ads = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final adData = ads[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.directions_car, color: Colors.orange.shade700, size: 40),
                  title: Text(
                    adData['title'] ?? adData['brand'] ?? 'Vehicle Ad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Price: ₹${adData['price'] ?? 'N/A'} | City: ${adData['city'] ?? 'N/A'}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // यहाँ आप चाहें तो विज्ञापन की पूरी डिटेल दिखाने के लिए नेविगेट कर सकते हैं
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('विज्ञापन पर क्लिक किया गया')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
