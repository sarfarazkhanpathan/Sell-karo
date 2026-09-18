import 'package:flutter/material.dart';
import 'image_helper.dart';
import 'video_reels_helper.dart';
import 'dart:io';

class SellPropertyScreen extends StatefulWidget {
  @override
  _SellPropertyScreenState createState() => _SellPropertyScreenState();
}

class _SellPropertyScreenState extends State<SellPropertyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedPropertyType = 'House / Villa';
  String selectedListingType = 'Sell';

  final List<String> propertyTypes = ['House / Villa', 'Plot / Land', 'Commercial Shop', 'Rent / PG'];
  final List<String> listingTypes = ['Sell', 'Rent / Lease'];

  List<File> _propertyImages = [];
  File? _propertyVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Buy/Sell & Rent'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apni Property ka Ad Lagayein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade800),
              ),
              SizedBox(height: 16),

              // Listing Type (Sell or Rent)
              DropdownButtonFormField<String>(
                value: selectedListingType,
                items: listingTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedListingType = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Bechna hai ya Kiraye par dena hai?',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Property Type
              DropdownButtonFormField<String>(
                value: selectedPropertyType,
                items: propertyTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedPropertyType = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Property ka Prakar (Type)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Title / Headline
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Ad Title (Jaise: 3 BHK Independent House in City...)',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya title likhein' : null,
              ),
              SizedBox(height: 16),

              // Size / Area
              TextFormField(
                controller: sizeController,
                decoration: InputDecoration(
                  labelText: 'Size / Area (Jaise: 1200 Sq. Feet, 10 Biswa...)',
                  prefixIcon: Icon(Icons.aspect_ratio),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya size likhein' : null,
              ),
              SizedBox(height: 16),

              // Price
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kimat ya Kiraya (Price in ₹)',
                  prefixIcon: Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya kimat likhein' : null,
              ),
              SizedBox(height: 16),

              // Location
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Pura Pata (State, City, Colony / Kasba)',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya location likhein' : null,
              ),
              SizedBox(height: 16),

              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Property ki Visheshtaayein (Water supply, Parking...)',
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
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: ImageUploadWidget(
                  onImagesSelected: (images) {
                    setState(() {
                      _propertyImages = images;
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
                      _propertyVideo = video;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_propertyImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kripya property ki kam se kam ek photo jaroor upload karein!')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Aapka Property Ad safaltapoorvak live ho gaya hai!')),
                    );
                  }
                },
                child: Text(
                  'Property Ad Live Karein',
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
