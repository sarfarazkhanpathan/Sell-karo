import 'package:flutter/material.dart';

void main() {
  runApp(DigitalShopApp());
}

class DigitalShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro - Digital Shop / Storefront',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: DigitalShopScreen(),
    );
  }
}

class DigitalShopScreen extends StatefulWidget {
  @override
  _DigitalShopScreenState createState() => _DigitalShopScreenState();
}

class _DigitalShopScreenState extends State<DigitalShopScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory = 'General Store / Kirana';

  final List<String> shopCategories = [
    'General Store / Kirana',
    'Clothing & Fashion Store',
    'Mobile & Electronics Shop',
    'Footwear & Accessories',
    'Hardware & Sanitary',
    'Home Decor & Furniture',
    'Bakery & Sweets',
    'Other Local Business'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apni Digital Shop Kholein (Storefront)'),
        backgroundColor: Colors.deepOrange.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apni Dukan ko Digital Mall par Register Karein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800),
              ),
              SizedBox(height: 16),

              // Shop Name
              TextFormField(
                controller: shopNameController,
                decoration: InputDecoration(
                  labelText: 'Dukan ka Naam (Shop Name)',
                  prefixIcon: Icon(Icons.store),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya dukan ka naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Owner Name
              TextFormField(
                controller: ownerNameController,
                decoration: InputDecoration(
                  labelText: 'Sanchalak / Malik ka Naam (Owner Name)',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya apna naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Shop Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                isExpanded: true,
                items: shopCategories.map((String cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Dukan ki Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number (WhatsApp Enabled)',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.length < 10 ? 'Sahi mobile number likhein' : null,
              ),
              SizedBox(height: 16),

              // Address (All India location)
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Pura Pata (State, City, Market / Kasba)',
                  prefixIcon: Icon(Icons.location_pin),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya pata likhein' : null,
              ),
              SizedBox(height: 16),

              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Dukan ke baare mein kuch khas batein (Special Offers, Items...)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Aapki Digital Shop safaltapoorvak live ho gayi hai!')),
                    );
                  }
                },
                child: Text(
                  'Digital Shop Live Karein',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
