import 'package:flutter/material.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro All-India Location',
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

  // Pure Bharat (All India) ke States aur unke pramukh Cities ki auto-list
  final Map<String, List<String>> allIndiaStatesAndCities = {
    'Gujarat': [
      'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 
      'Jamnagar', 'Junagadh', 'Gandhinagar', 'Anand', 'Mehsana', 'Vapi', 'Navsari'
    ],
    'Maharashtra': [
      'Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad', 
      'Solapur', 'Thane', 'Kolhapur', 'Amravati', 'Nanded'
    ],
    'Delhi': [
      'New Delhi', 'North Delhi', 'South Delhi', 'East Delhi', 'West Delhi', 'Dwarka', 'Rohini'
    ],
    'Uttar Pradesh': [
      'Lucknow', 'Kanpur', 'Ghaziabad', 'Agra', 'Varanasi', 
      'Meerut', 'Prayagraj', 'Bareilly', 'Aligarh', 'Moradabad', 'Noida'
    ],
    'Rajasthan': [
      'Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer', 
      'Bikaner', 'Alwar', 'Bhilwara', 'Sikar', 'Pali'
    ],
    'Karnataka': [
      'Bengaluru', 'Mysuru', 'Hubballi-Dharwad', 'Mangaluru', 'Belagavi', 'Kalaburagi'
    ],
    'Tamil Nadu': [
      'Chennai', 'Coimbatore', 'Madurai', 'Tiruchirappalli', 'Salem', 'Tirunelveli'
    ],
    'West Bengal': [
      'Kolkata', 'Howrah', 'Durgapur', 'Asansol', 'Siliguri', 'Kharagpur'
    ],
    'Madhya Pradesh': [
      'Bhopal', 'Indore', 'Gwalior', 'Jabalpur', 'Ujjain', 'Sagar', 'Dewas'
    ],
    'Punjab': [
      'Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala', 'Bathinda', 'Mohali'
    ],
    'Bihar': [
      'Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur', 'Purnia', 'Darbhanga'
    ],
    'Haryana': [
      'Gurugram', 'Faridabad', 'Panipat', 'Ambala', 'Yamunanagar', 'Rohtak', 'Hisar'
    ],
    'Telangana': [
      'Hyderabad', 'Warangal', 'Nizamabad', 'Khammam', 'Karimnagar'
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<String> availableCities = allIndiaStatesAndCities[selectedState] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pura Bharat - Location Chunein'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'State (Rajya) Chunein (All India)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedState,
              isExpanded: true,
              items: allIndiaStatesAndCities.keys.map((String state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedState = newValue;
                  selectedCity = null; // State badalte hi city reset ho jayegi aur naye state ki cities aa jayengi
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
                          SnackBar(content: Text('Location Set: $city, $selectedState (All India)')),
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
