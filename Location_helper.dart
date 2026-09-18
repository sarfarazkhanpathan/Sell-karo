import 'package:flutter/material.dart';

void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro All-India Location Finder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AllIndiaLocationScreen(),
    );
  }
}

class AllIndiaLocationScreen extends StatefulWidget {
  @override
  _AllIndiaLocationScreenState createState() => _AllIndiaLocationScreenState();
}

class _AllIndiaLocationScreenState extends State<AllIndiaLocationScreen> {
  TextEditingController _searchController = TextEditingController();

  // Bharat ke sabhi 28 States aur Union Territories ki master list
  final List<String> allStatesAndUTs = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand',
    'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', ' मणिपुर (Manipur)',
    'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab',
    'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura',
    'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi (NCR)', 'Jammu and Kashmir', 'Ladakh', 'Lakshadweep', 'Puducherry'
  ];

  // Sample dynamic database representing major cities, districts, towns, and villages across India
  // User yahan koi bhi gaon ya kasba type karke search kar sakega
  final List<String> allLocations = [
    // Gujarat Villages/Towns/Cities
    'Ahmedabad', 'Sanand', 'Dholka', 'Viramgam', 'Bavla', 'Surat', 'Bardoli', 'Navsari', 'Valsad',
    'Vadodara', 'Padra', 'Karjan', 'Rajkot', 'Gondal', 'Jetpur', 'Dhoraji', 'Jamnagar', 'Junagadh',
    'Amreli', 'Bhavnagar', 'Palitana', 'Anand', 'Nadiad', 'Borsad', 'Mehsana', 'Patan', 'Palanpur',
    'Bhuj', 'Anjar', 'Gandhidham', 'Godhra', 'Dahod', 'Himmatnagar', 'Modasa', 'Vapi', 'Silvassa',
    
    // Maharashtra
    'Mumbai', 'Thane', 'Pune', 'Baramati', 'Nagpur', 'Nashik', 'Malegaon', 'Aurangabad', 'Kolhapur',
    'Sangli', 'Satara', 'Solapur', 'Amravati', 'Nanded', 'Jalgaon', 'Latur', 'Akola', 'Chandrapur',

    // Uttar Pradesh
    'Lucknow', 'Kanpur', 'Varanasi', 'Agra', 'Prayagraj', 'Meerut', 'Ghaziabad', 'Noida', 'Bareilly',
    'Aligarh', 'Moradabad', 'Gorakhpur', 'Faizabad', 'Jhansi', 'Mathura', 'Muzaffarnagar', 'Basti', 'Azamgarh',

    // Bihar
    'Patna', 'Gaya', 'Muzaffarpur', 'Bhagalpur', 'Purnia', 'Darbhanga', 'Bihar Sharif', 'Ara', 'Begusarai',
    'Katihar', 'Munger', 'Chhapra', 'Siwan', 'Bettiah', 'Madhubani', 'Saharsa', 'Sasaram', 'Hajipur',

    // Rajasthan
    'Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer', 'Bikaner', 'Alwar', 'Bhilwara', 'Sikar', 'Pali',
    'Barmer', 'Churu', 'Nagaur', 'Tonk', 'Kishangarh', 'Hanumangarh', 'Beawar', 'Jhunjhunu',

    // Madhya Pradesh & Others
    'Bhopal', 'Indore', 'Gwalior', 'Jabalpur', 'Ujjain', 'Sagar', 'Dewas', 'Satna', 'Ratlam', 'Rewa',
    'Delhi', 'New Delhi', 'Gurugram', 'Faridabad', 'Chandigarh', 'Ludhiana', 'Amritsar', 'Jalandhar',
    'Bengaluru', 'Mysuru', 'Hubballi', 'Chennai', 'Coimbatore', 'Madurai', 'Kolkata', 'Howrah', 'Siliguri',
    'Hyderabad', 'Warangal', 'Visakhapatnam', 'Vijayawada', 'Guwahati', 'Ranchi', 'Jamshedpur', 'Raipur'
  ];

  List<String> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = allLocations;
  }

  void _filterLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLocations = allLocations;
      } else {
        filteredLocations = allLocations
            .where((loc) => loc.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All India Village, Town & City Finder'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apna Rajya (State) Chunein:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey.h700 ?? Colors.grey),
            ),
            SizedBox(height: 6),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allStatesAndUTs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text(allStatesAndUTs[index]),
                      backgroundColor: Colors.orange.shade100,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Rajya Chuna gaya: ${allStatesAndUTs[index]}')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: _filterLocations,
              decoration: InputDecoration(
                labelText: 'Apna Gaon, Kasba ya City Search Karein...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Upalabdh Shehar / Kasbe / Gaon (${filteredLocations.length}):',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Icon(Icons.location_pin, color: Colors.orange.shade800),
                      title: Text(filteredLocations[index]),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Location Set: ${filteredLocations[index]} (All India)')),
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
