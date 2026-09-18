import 'package:flutter/material.dart';
import 'image_helper.dart'; // Image picker helper import kiya gaya hai
import 'dart:io';

class MatrimonyScreen extends StatefulWidget {
  @override
  _MatrimonyScreenState createState() => _MatrimonyScreenState();
}

class _MatrimonyScreenState extends State<MatrimonyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedProfileFor = 'Bride (Dulhan)';
  String selectedReligion = 'Islam';
  
  List<File> _profileImages = [];

  final List<String> profileTypes = ['Bride (Dulhan)', 'Groom (Dulha)'];
  final List<String> religions = ['Islam', 'Hindu', 'Sikh', 'Christian', 'Jain', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrimony (Rishte) Registration'),
        backgroundColor: Colors.pink.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key_form: _formKey,
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Apne Ya Apne Parivar ke liye Rishta Jodein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink.shade800),
              ),
              SizedBox(height: 16),

              // Profile For (Bride / Groom)
              DropdownButtonFormField<String>(
                value: selectedProfileFor,
                items: profileTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedProfileFor = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Profile kiske liye hai?',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Full Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Pura Naam (Full Name)',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya naam likhein' : null,
              ),
              SizedBox(height: 16),

              // Age
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Umar (Age in Years)',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya umar likhein' : null,
              ),
              SizedBox(height: 16),

              // Religion Dropdown
              DropdownButtonFormField<String>(
                value: selectedReligion,
                items: religions.map((rel) {
                  return DropdownMenuItem(value: rel, child: Text(rel));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedReligion = val!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Dharm / Religion',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 16),

              // Education
              TextFormField(
                controller: educationController,
                decoration: InputDecoration(
                  labelText: 'Padhai / Education (Degree)',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya education likhein' : null,
              ),
              SizedBox(height: 16),

              // Profession
              TextFormField(
                controller: professionController,
                decoration: InputDecoration(
                  labelText: 'Naukri ya Business (Profession)',
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya profession likhein' : null,
              ),
              SizedBox(height: 16),

              // City & Location
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'Shehar / Location (City, State)',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                validator: (val) => val!.isEmpty ? 'Kripya shehar likhein' : null,
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

              // --- IMAGE UPLOAD WIDGET INTEGRATION ---
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink.shade200),
                ),
                child: ImageUploadWidget(
                  onImagesSelected: (images) {
                    setState(() {
                      _profileImages = images;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_profileImages.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kripya kam se kam ek photo zaroor upload karein!')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Matrimony profile safaltapoorvak live ho gayi hai!')),
                    );
                  }
                },
                child: Text(
                  'Rishta Profile Live Karein',
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
