import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'image_helper.dart';
import 'video_helper.dart';
import 'location_helper.dart';

class SellBusinessScreen extends StatefulWidget {
  @override
  _SellBusinessScreenState createState() => _SellBusinessScreenState();
}

class _SellBusinessScreenState extends State<SellBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance.collection('business').add({
          'title': _titleController.text.trim(),
          'category': _categoryController.text.trim(),
          'price': _priceController.text.trim(),
          'description': _descController.text.trim(),
          'createdAt': Timestamp.now(),
        });
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('बिजनेस/मशीनरी का विज्ञापन Firebase पर सफलतापूर्वक सेव हो गया है!')),
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
        title: Text('Sell Business & Machinery'),
        backgroundColor: Colors.red.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'कमर्शियल और मशीनरी विवरण (All-India)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Business / Machine Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया टाइटल दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Type (Shop, Factory, Heavy Machine)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Asking Price (INR)',
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
                        backgroundColor: Colors.red.shade800,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Submit Business Ad to Firebase',
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
