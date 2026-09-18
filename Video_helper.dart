import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VideoReelsUploadWidget extends StatefulWidget {
  final Function(File?) onVideoSelected;

  VideoReelsUploadWidget({required this.onVideoSelected});

  @override
  _VideoReelsUploadWidgetState createState() => _VideoReelsUploadWidgetState();
}

class _VideoReelsUploadWidgetState extends State<VideoReelsUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedVideo;

  // Camera se short reel / video record karne ke liye
  Future<void> _recordVideoFromCamera() async {
    final XFile? recordedFile = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: Duration(seconds: 30), // 30 second ki short reel limit
    );
    if (recordedFile != null) {
      setState(() {
        _selectedVideo = File(recordedFile.path);
      });
      widget.onVideoSelected(_selectedVideo);
    }
  }

  // Gallery se existing video chunte ke liye
  Future<void> _pickVideoFromGallery() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedVideo = File(pickedFile.path);
      });
      widget.onVideoSelected(_selectedVideo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apni Item ki Video Reel Banayein (Max 30 Sec)',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _recordVideoFromCamera,
              icon: Icon(Icons.videocam),
              label: Text('Record Reel'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade700, foregroundColor: Colors.white),
            ),
            SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _pickVideoFromGallery,
              icon: Icon(Icons.video_library),
              label: Text('Gallery Video'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange.shade700, foregroundColor: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10),
        _selectedVideo == null
            ? Text('Abhi koi video reel nahi jodi gayi hai.', style: TextStyle(color: Colors.grey.shade600, fontSize: 13))
            : Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.purple.shade800, size: 36),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Video Reel Chuni gayi: ${_selectedVideo!.path.split('/').last}',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _selectedVideo = null;
                        });
                        widget.onVideoSelected(null);
                      },
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
