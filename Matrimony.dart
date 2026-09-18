import 'package:flutter/material.dart';

void main() {
  runApp(MatrimonyApp());
}

class MatrimonyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro Matrimony',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MatrimonyFormScreen(),
    );
  }
}

class MatrimonyFormScreen extends StatefulWidget {
  @override
  _MatrimonyFormScreenState createState() => _MatrimonyFormScreenState();
}

class _MatrimonyFormScreenState extends State<MatrimonyFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  
  String _selectedGender = 'Male';
  String _selectedReligion = 'Hindu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rishte Banayein (Matrimony)'),
        backgroundColor: Colors.pink.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Apne ya Apne Parivar ke liye Rishta Jodein',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade800,
              ),
            ),
            SizedBox(height: 16),
            
            // Full Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Poora Naam (Full Name)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),
            
            // Age & Gender Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Umar (Age)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedGender,
                    items: ['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Ling (Gender)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            
            // Religion Dropdown
            DropdownButtonFormField<String>(
              value: _selectedReligion,
              items: ['Hindu', 'Muslim', 'Sikh', 'Christian', 'Jain', 'Other'].map((String religion) {
                return DropdownMenuItem(
                  value: religion,
                  child: Text(religion),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedReligion = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Dharm (Religion)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),
            
            // Profession
            TextField(
              controller: _professionController,
              decoration: InputDecoration(
                labelText: 'Pesha / Naukri (Profession)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 12),
            
            // City
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Shehar (City)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Rishte ki profile safalta-purvak jud gayi hai!')),
                  );
                },
                child: Text(
                  'Rishta Profile Submit Karein',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
