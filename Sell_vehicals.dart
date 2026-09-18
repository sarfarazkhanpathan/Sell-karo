import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'image_helper.dart';
import 'video_helper.dart';
import 'location_helper.dart';

class SellVehicleScreen extends StatefulWidget {
  @override
  _SellVehicleScreenState createState() => _SellVehicleScreenState();
}

class _SellVehicleScreenState extends State<SellVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Firebase Firestore में डेटा सेव करना
        await FirebaseFirestore.instance.collection('vehicles').add({
          'title': _titleController.text.trim(),
          'brand': _brandController.text.trim(),
          'model': _modelController.text.trim(),
          'year': _yearController.text.trim(),
          'price': _priceController.text.trim(),
          'description': _descController.text.trim(),
          'createdAt': Timestamp.now(),
        });

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('गाड़ी का विज्ञापन सफलतापूर्वक Firebase पर सेव हो गया है!')),
        );

        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('डेटा सेव करने में त्रुटि: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Vehicle (Cars & Bikes)'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'अपनी गाड़ी की जानकारी भरें (All-India)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Ad Title (e.g. Honda City 2020 Model)', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'कृपया टाइटल दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand (e.g. Honda, Maruti, Hyundai)', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'कृपया ब्रांड दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Model', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'कृपया मॉडल दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Manufacturing Year', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'कृपया वर्ष दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price (in INR)', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'कृपया कीमत दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              
              // Multimedia helpers integration
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
                        backgroundColor: Colors.blue.shade800,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Submit Ad to Firebase',
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
