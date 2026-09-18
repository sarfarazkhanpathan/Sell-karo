// All-India States Dropdown (State Select karne ke liye)
String selectedState = 'Uttar Pradesh'; // Default state
final List<String> indianStates = [
  'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
  'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
  'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram',
  'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu',
  'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
  'Delhi (UT)', 'Jammu & Kashmir (UT)', 'Ladakh (UT)', 'Other UTs'
];

// Form ke andar ise dropdown ki tarah rakh sakte hain:
DropdownButtonFormField<String>(
  value: selectedState,
  items: indianStates.map((state) {
    return DropdownMenuItem(value: state, child: Text(state));
  }).toList(),
  onChanged: (val) {
    setState(() {
      selectedState = val!;
    });
  },
  decoration: InputDecoration(
    labelText: 'State / Rajya (All-India Coverage)',
    prefixIcon: Icon(Icons.map),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    filled: true,
    fillColor: Colors.grey.shade100,
  ),
),
