import 'package:flutter/material.dart';

class LocationHelperWidget extends StatefulWidget {
  @override
  _LocationHelperWidgetState createState() => _LocationHelperWidgetState();
}

class _LocationHelperWidgetState extends State<LocationHelperWidget> {
  final TextEditingController _locationController = TextEditingController();
  bool _isLocationAdded = false;

  void _saveLocation() {
    if (_locationController.text.trim().isNotEmpty) {
      setState(() {
        _isLocationAdded = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('लोकेशन सफलतापर्वक जोड़ दी गई है!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('कृपया सही लोकेशन या शहर का नाम दर्ज करें')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location / City (लोकेशन या शहर)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Enter City / Area (e.g. Mumbai, Delhi)',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: _saveLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              child: Text('Set'),
            ),
          ],
        ),
        SizedBox(height: 4),
        _isLocationAdded
            ? Text('Location Saved ✅', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold))
            : Text('Location not set', style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
