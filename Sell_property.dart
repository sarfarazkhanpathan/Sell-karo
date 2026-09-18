import 'package:flutter/material.dart';

void main() {
  runApp(SellPropertyApp());
}

class SellPropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro - Property',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SellPropertyScreen(),
    );
  }
}

class SellPropertyScreen extends StatefulWidget {
  @override
  _SellPropertyScreenState createState() => _SellPropertyScreenState();
}

class _SellPropertyScreenState extends State<SellPropertyScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bhkController = TextEditingController();
  final TextEditingController _sqftController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _selectedPropertyType = 'Apartment / Flat';
  String _selectedListingType = 'Sell'; // Sell ya Rent
  String _selectedCity = 'Ahmedabad';

  final List<String> citiesOfGujarat = [
    'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Jamnagar', 'Gandhinagar', 'Anand'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Bechein ya Kiraye par Dein'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Property ki Jankari Darj Karein',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade900),
            ),
            SizedBox(height: 16),

            // Sell or Rent Dropdown
            DropdownButtonFormField<String>(
              value: _selectedListingType,
              items: ['Sell (Bechna hai)', 'Rent (Kiraye par dena hai)'].map((String type) {
                return DropdownMenuItem(value: type.split(' ')[0], child: Text(type));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedListingType = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Aap kya karna chahte hain?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Property Type
            DropdownButtonFormField<String>(
              value: _selectedPropertyType,
              items: ['Apartment / Flat', 'Independent House / Villa', 'Plot / Land', 'Commercial Shop / Office'].map((String type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedPropertyType = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Property ka Prakar (Type)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // Ad Title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Ad Title (jaise: 3 BHK Luxury Flat in SG Highway)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // BHK & Sqft Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _bhkController,
                    decoration: InputDecoration(
                      labelText: 'BHK (jaise: 2 BHK, 3 BHK)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _sqftController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Area (Sq. Ft.)',
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
                labelText: 'Kul Keemat ya Kiraya (in ₹)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),

            // City Selection
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
                labelText: 'Property ki visheshnayein (amenities) likhein...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 24),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Aapki Property ki Ad safalta-purvak live ho gayi hai!')),
                  );
                },
                child: Text(
                  'Property Ad Post Karein',
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
