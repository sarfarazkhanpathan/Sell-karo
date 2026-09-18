import 'package:flutter/material.dart';
import 'image_helper.dart';
import 'video_reels_helper.dart';
import 'dart:io';

class SellBusinessScreen extends StatefulWidget {
  @override
  _SellBusinessScreenState createState() => _SellBusinessScreenState();
}

class _SellBusinessScreenState extends State<SellBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  List<File> _businessImages = [];
  File? _businessVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business & Machinery Buy/Sell'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apna Business, Factory ya Machinery Sale par Lagayein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red.shade800),
              ),
              SizedBox(height: 16),

              // Business Name
              TextFormField(
                controller: businessNameController,
                decoration: InputDecoration(
                  labelText: 'Business / Machinery ka Naam',
                  prefixIcon: Icon(Icons.storefront),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Business Type / Category
              TextFormField(
                controller: businessTypeController,
                decoration: InputDecoration(
                  labelText: 'Kiske liye hai? (Jaise: Restaurant, Factory Machine, Shop...)',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya category likhein' : null,
              ),
              SizedBox(height: 16),

              // Asking Price
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

              // Location
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location (State, City, Market Area)',
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
                  labelText: 'Details / Visheshtaayein (Profit, Age, Condition...)',
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
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: ImageUploadWidget(
                  onImagesSelected: (images) {
                    setState(() {
                      _businessImages = images;
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
                      _businessVideo = video;
                    });
                  },
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
                    if (_businessImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kripya business ya machinery ki kam se kam ek photo jaroor dein!')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Aapka Business Ad safaltapoorvak live ho gaya hai!')),
                    );
                  }
                },
                child: Text(
                  'Business Ad Live Karein',
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
