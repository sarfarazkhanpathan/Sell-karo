import 'package:flutter/material.dart';

void main() {
  runApp(JobsApp());
}

class JobsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro Jobs',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: JobsScreen(),
    );
  }
}

class JobsScreen extends StatelessWidget {
  final List<Map<String, String>> jobList = [
    {'title': 'Delivery Executive', 'company': 'Quick Logistics', 'salary': '₹18,000 - ₹25,000', 'location': 'Ahmedabad'},
    {'title': 'Data Entry Operator', 'company': 'Digital Solutions', 'salary': '₹15,000 - ₹20,000', 'location': 'Surat'},
    {'title': 'Shop Salesman', 'company': 'Fashion Hub', 'salary': '₹12,000 - ₹16,000', 'location': 'Vadodara'},
    {'title': 'Telecaller / Support', 'company': 'VoiceNet Tech', 'salary': '₹14,000 - ₹18,000', 'location': 'Rajkot'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naukri & Rojgar (Jobs)'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apne Bhavishye ke liye Sahi Naukri Chunein',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: jobList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobList[index]['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            jobList[index]['company']!,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                jobList[index]['salary']!,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700),
                              ),
                              Text(
                                jobList[index]['location']!,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade800,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Aapne is naukri ke liye apply kar diya hai!')),
                                );
                              },
                              child: Text('Apply Karein', style: TextStyle(color: Colors.white)),
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
