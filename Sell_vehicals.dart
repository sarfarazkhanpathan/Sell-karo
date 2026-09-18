import 'package:flutter/material.dart';

void main() {
  runApp(SellVehicleApp());
}

class SellVehicleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro - Cars & Bikes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SellVehicleScreen(),
    );
  }
}

class SellVehicleScreen extends StatefulWidget {
  @override
  _SellVehicleScreenState createState() => _SellVehicleScreenState();
}

class _SellVehicleScreenState extends State<SellVehicleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _selectedVehicleType = 'Car';
  String _selectedState = 'Gujarat';
  String _selectedCity = 'Ahmedabad';

  final List<String> citiesOfGujarat = [
    'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Jamnagar', 'Gandhinagar', 'Anand'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gaadi ya Bike Bechein (Post Ad)'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Apne Vahan ki Jankari Deen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
            ),
            SizedBox(height: 16),

            // Vehicle Type (Car / Bike)
            DropdownButtonFormField<String>(
              value: _selectedVehicleType,
              items: ['Car', 'Bike', 'Scooter', 'Commercial Vehicle'].map((String type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedVehicleType = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Vahan ka Prakar (Type)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Ad Title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Ad Title ( jaise: Maruti Swift 2020 Model )',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Brand / Model
            TextField(
              controller: _brandController,
              decoration: InputDecoration(
                labelText: 'Company / Brand (jaise: Hyundai, Honda)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Year & KM Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Model Year',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _kmController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Kilometers Driven',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Price
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Keemat / Price (in ₹)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Location: City Selector (Gujarat Auto-List)
            DropdownButtonFormField<String>(
              value: _selectedCity,
              items: citiesOfGujarat.map((String city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCity = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Shehar (Gujarat)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Description
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Vahan ke bare mein kuch aur batayein...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 24),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Aapki Vahan (Vehicle) ki Ad safalta-purvak live ho gayi hai!')),
                  );
                },
                child: Text(
                  'Ad Post Karein',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
