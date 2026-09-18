import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'image_helper.dart';
import 'video_helper.dart';
import 'location_helper.dart';

class SellFurnitureAppliancesScreen extends StatefulWidget {
  @override
  _SellFurnitureAppliancesScreenState createState() => _SellFurnitureAppliancesScreenState();
}

class _SellFurnitureAppliancesScreenState extends State<SellFurnitureAppliancesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance.collection('furniture_appliances').add({
          'title': _titleController.text.trim(),
          'itemType': _itemController.text.trim(),
          'price': _priceController.text.trim(),
          'description': _descController.text.trim(),
          'createdAt': Timestamp.now(),
        });
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('फर्नीचर/अप्लायंसेज का विज्ञापन Firebase पर सफलतापूर्वक सेव हो गया है!')),
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
        title: Text('Furniture & Appliances'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'घरेलू सामान और फर्नीचर विवरण (All-India)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Item Title (e.g. Sofa Set / Fridge)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया टाइटल दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: 'Condition (New / Used)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price (INR)',
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
                        backgroundColor: Colors.teal.shade700,
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
