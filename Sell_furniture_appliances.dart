import 'package:flutter/material.dart';
import 'image_helper.dart';
import 'video_reels_helper.dart';
import 'dart:io';

class SellFurnitureAppliancesScreen extends StatefulWidget {
  @override
  _SellFurnitureAppliancesScreenState createState() => _SellFurnitureAppliancesScreenState();
}

class _SellFurnitureAppliancesScreenState extends State<SellFurnitureAppliancesScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedCategory = 'Furniture (Sofa, Bed, Table...)';
  final List<String> categories = [
    'Furniture (Sofa, Bed, Table...)',
    'Home Appliances (AC, Fridge, TV...)',
    'Kitchen Appliances (Microwave, Mixer...)',
    'Garden & Outdoor Items'
  ];

  // All-India States List
  String selectedState = 'Uttar Pradesh';
  final List<String> indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
    'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram',
    'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',
    'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    'Delhi (UT)', 'Jammu & Kashmir (UT)', 'Ladakh (UT)', 'Other States/UTs'
  ];

  List<File> _itemImages = [];
  File? _itemVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Furniture & Appliances (All-India)'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Ghar ka Samaan, Furniture ya Appliances Bechein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal.shade800),
              ),
              SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Samaan ki Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Title / Item Name
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Samaan ka Naam (Jaise: Wooden Sofa, LG Double Door Fridge...)',
                  prefixIcon: Icon(Icons.weekend),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Price
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Maangti Kimat (Price in ₹)',
                  prefixIcon: Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya kimat likhein' : null,
              ),
              SizedBox(height: 16),

              // All-India State Dropdown
              DropdownButtonFormField<String>(
                value: selectedState,
                items: indianStates.map((state) {
                  return DropdownMenuItem(value: state, child: Text(state));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedState = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'State / Rajya (All-India Coverage)',
                  prefixIcon: Icon(Icons.map),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // City / Village Name
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'Shehar, Kasba ya Gaon ka Naam (City / Village)',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya shehar ya gaon likhein' : null,
              ),
              SizedBox(height: 16),

              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Condition aur Purana Kitna hai (Jaise: 1 Year old, Good condition...)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Contact Number
              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Sampark Mobile Number (WhatsApp)',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.length < 10 ? 'Sahi mobile number likhein' : null,
              ),
              SizedBox(height: 20),

              // --- IMAGE UPLOAD WIDGET ---
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: ImageUploadWidget(
                  onImagesSelected: (images) {
                    setState(() {
                      _itemImages = images;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),

              // --- VIDEO REELS WIDGET ---
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: VideoReelsUploadWidget(
                  onVideoSelected: (video) {
                    setState(() {
                      _itemVideo = video;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_itemImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kripya samaan ki kam se kam ek photo jaroor upload karein!')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Aapka Samaan Ad All-India level par live ho gaya hai!')),
                    );
                  }
                },
                child: Text(
                  'Samaan Ad Live Karein',
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
