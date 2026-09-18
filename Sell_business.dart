import 'package:flutter/material.dart';

void main() {
  runApp(SellBusinessApp());
}

class SellBusinessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro - Business Buy/Sell',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SellBusinessScreen(),
    );
  }
}

class SellBusinessScreen extends StatefulWidget {
  @override
  _SellBusinessScreenState createState() => _SellBusinessScreenState();
}

class _SellBusinessScreenState extends State<SellBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String? businessType;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController turnoverController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final List<String> businessCategories = [
    'Retail Shop / Dukan',
    'Restaurant / Cafe / Food',
    'Manufacturing Unit / Factory',
    'Franchise / Dealership',
    'IT Startup / Software Agency',
    'Salon / Spa / Fitness',
    'E-commerce Business',
    'Other Service Business'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apna Business Bechein / Kharidein'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Business ki Jankari Bharein (All India)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red.shade800),
              ),
              SizedBox(height: 16),
              
              // Business Category Dropdown
              DropdownButtonFormField<String>(
                value: businessType,
                hint: Text('Business ki Category Chunein'),
                isExpanded: true,
                items: businessCategories.map((String cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    businessType = val;
                  });
                },
                validator: (val) => val == null ? 'Kripya category chunein' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Business Title / Name
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Business ka Naam / Title (Jaise: Fancy Garment Store)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Monthly Turnover
              TextFormField(
                controller: turnoverController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Lagbhag Masik Turnover (Monthly Sales in ₹)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Asking Price
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mangni Ki Kimat (Asking Price in ₹)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya kimat likhein' : null,
              ),
              SizedBox(height: 16),

              // Location (State, City, Town)
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location (State, City, Kasba ya Gaon)',
                  prefixIcon: Icon(Icons.location_pin),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya location likhein' : null,
              ),
              SizedBox(height: 16),

              // Description
              TextFormField(
                controller: descController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Business ke baare mein vistar se batayein (Profit, Reason for selling...)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Aapka Business Ad safaltapoorvak post ho gaya hai!')),
                    );
                  }
                },
                child: Text(
                  'Business Ad Post Karein',
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
