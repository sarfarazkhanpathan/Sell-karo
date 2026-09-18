import 'package:flutter/material.dart';
import 'image_helper.dart';
import 'video_reels_helper.dart';
import 'dart:io';

class SellVehicleScreen extends StatefulWidget {
  @override
  _SellVehicleScreenState createState() => _SellVehicleScreenState();
}

class _SellVehicleScreenState extends State<SellVehicleScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController kmDrivenController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedVehicleType = 'Car';
  final List<String> vehicleTypes = ['Car', 'Bike / Scooter', 'Commercial Vehicle', 'tractor'];

  List<File> _vehicleImages = [];
  File? _vehicleVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars & Bikes Sell Karein'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apni Gaadi ki Details Bharein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
              ),
              SizedBox(height: 16),

              // Vehicle Type Dropdown
              DropdownButtonFormField<String>(
                value: selectedVehicleType,
                items: vehicleTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedVehicleType = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Gaadi ka Prakar (Vehicle Type)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Brand / Company Name
              TextFormField(
                controller: brandController,
                decoration: InputDecoration(
                  labelText: 'Company / Brand (Jaise: Maruti, Honda, Bajaj...)',
                  prefixIcon: Icon(Icons.directions_car),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya brand ka naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Model Name
              TextFormField(
                controller: modelController,
                decoration: InputDecoration(
                  labelText: 'Model (Jaise: Swift, Activa, Splendor...)',
                  prefixIcon: Icon(Icons.model_training),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya model likhein' : null,
              ),
              SizedBox(height: 16),

              // Manufacturing Year
              TextFormField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Model ka Saal (Manufacturing Year)',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya saal likhein' : null,
              ),
              SizedBox(height: 16),

              // Kilometers Driven
              TextFormField(
                controller: kmDrivenController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kitni Chali hai? (KM Driven)',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya KM likhein' : null,
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

              // Location
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location (State, City, Area)',
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
                  labelText: 'Gaadi ke baare mein kuch aur (Insurance, Condition...)',
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: ImageUploadWidget(
                  onImagesSelected: (images) {
                    setState(() {
                      _vehicleImages = images;
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
                      _vehicleVideo = video;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_vehicleImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kripya gaadi ki kam se kam ek photo jaroor upload karein!')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Aapka Vehicle Ad safaltapoorvak live ho gaya hai!')),
                    );
                  }
                },
                child: Text(
                  'Vehicle Ad Live Karein',
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
