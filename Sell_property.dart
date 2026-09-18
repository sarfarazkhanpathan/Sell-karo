import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'image_helper.dart';
import 'video_helper.dart';
import 'location_helper.dart';

class SellPropertyScreen extends StatefulWidget {
  @override
  _SellPropertyScreenState createState() => _SellPropertyScreenState();
}

class _SellPropertyScreenState extends State<SellPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _bhkController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance.collection('properties').add({
          'title': _titleController.text.trim(),
          'propertyType': _typeController.text.trim(),
          'bhk': _bhkController.text.trim(),
          'price': _priceController.text.trim(),
          'description': _descController.text.trim(),
          'createdAt': Timestamp.now(),
        });
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('प्रॉपर्टी का विज्ञापन Firebase पर सफलतापूर्वक सेव हो गया है!')),
        );
        Navigator.pop(context);
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('त्रुटि: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell / Rent Property'),
        backgroundColor: Colors.green.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'प्रॉपर्टी की डिटेल भरें (All-India)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title (e.g. 3 BHK Apartment)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया टाइटल दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: 'Type (Sell / Rent)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया टाइप दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _bhkController,
                decoration: InputDecoration(
                  labelText: 'BHK (1, 2, 3 BHK)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price / Rent (INR)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया कीमत दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              LocationHelperWidget(),
              SizedBox(height: 12),
              ImagePickerWidget(),
              SizedBox(height: 12),
              VideoPickerWidget(),
              SizedBox(height: 24),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Submit Property Ad to Firebase',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
