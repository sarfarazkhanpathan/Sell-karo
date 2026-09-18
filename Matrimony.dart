import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'image_helper.dart';
import 'video_helper.dart';
import 'location_helper.dart';

class MatrimonyScreen extends StatefulWidget {
  @override
  _MatrimonyScreenState createState() => _MatrimonyScreenState();
}

class _MatrimonyScreenState extends State<MatrimonyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance.collection('matrimony').add({
          'fullName': _nameController.text.trim(),
          'age': _ageController.text.trim(),
          'religion': _religionController.text.trim(),
          'occupation': _occupationController.text.trim(),
          'description': _descController.text.trim(),
          'createdAt': Timestamp.now(),
        });
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('मैट्रिमोनी प्रोफाइल Firebase पर सफलतापूर्वक सेव हो गई है!')),
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
        title: Text('Matrimony (Rishte)'),
        backgroundColor: Colors.pink.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'रिश्ते के लिए विवरण दर्ज करें (All-India)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया नाम दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया आयु दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _religionController,
                decoration: InputDecoration(
                  labelText: 'Religion / Community',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'कृपया धर्म दर्ज करें' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _occupationController,
                decoration: InputDecoration(
                  labelText: 'Occupation / Education',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Partner Expectations / Bio',
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
                        backgroundColor: Colors.pink.shade700,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Submit Matrimony Profile to Firebase',
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
