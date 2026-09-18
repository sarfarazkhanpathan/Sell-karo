import 'package:flutter/material.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro Location',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? selectedState = 'Gujarat';
  String? selectedCity;

  // Gujarat ke pramukh shehar jo state select hote hi auto-populate honge
  final Map<String, List<String>> stateToCities = {
    'Gujarat': [
      'Ahmedabad',
      'Surat',
      'Vadodara',
      'Rajkot',
      'Bhavnagar',
      'Jamnagar',
      'Junagadh',
      'Gandhinagar',
      'Anand',
      'Mehsana',
      'Navsari',
      'Vapi'
    ],
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Aurangabad'
    ],
    'Rajasthan': [
      'Jaipur',
      'Jodhpur',
      'Udaipur',
      'Kota',
      'Ajmer'
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<String> availableCities = stateToCities[selectedState] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Apni Location Chunein'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'State (Rajya) Chunein',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedState,
              items: stateToCities.keys.map((String state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedState = newValue;
                  selectedCity = null; // State badalte hi city reset ho jayegi
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Shehar (City) Auto-List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: availableCities.length,
                itemBuilder: (context, index) {
                  String city = availableCities[index];
                  bool isSelected = selectedCity == city;
                  return Card(
                    elevation: 1,
                    margin: EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text(city, style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: isSelected ? Icon(Icons.check_circle, color: Colors.orange.shade800) : null,
                      onTap: () {
                        setState(() {
                          selectedCity = city;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Location Set: $city, $selectedState')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
