import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VideoPickerWidget extends StatefulWidget {
  @override
  _VideoPickerWidgetState createState() => _VideoPickerWidgetState();
}

class _VideoPickerWidgetState extends State<VideoPickerWidget> {
  File? _selectedVideo;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedVideo = File(pickedFile.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('वीडियो सफलतापूर्वक चुन लिया गया है!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Product Video (वीडियो जोड़ें - Optional)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: Icon(Icons.videocam),
              label: Text('Select Video'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white),
            ),
            SizedBox(width: 16),
            _selectedVideo != null
                ? Text('Video Selected ✅', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                : Text('No video chosen', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
