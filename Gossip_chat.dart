import 'package:flutter/material.dart';

void main() {
  runApp(GossipChatApp());
}

class GossipChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellKaro Gupshup Room',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: GossipUsersListScreen(),
    );
  }
}

class GossipUsersListScreen extends StatelessWidget {
  // Yeh woh log hain jo abhi Gupshup/Gossip room mein online hain (Nicknames ke sath)
  final List<Map<String, String>> onlineUsers = [
    {'name': 'CoolRahi786', 'status': 'Gossip about cars & life...', 'gender': 'Male'},
    {'name': 'DesiGirl_99', 'status': 'Looking for casual chat', 'gender': 'Female'},
    {'name': 'MumbaiKing', 'status': 'Business & Startup talks', 'gender': 'Male'},
    {'name': 'Anjali_Delhi', 'status': 'Shaadi & Rishte discussion', 'gender': 'Female'},
    {'name': 'SpeedBiker', 'status': 'Bikes and long drives', 'gender': 'Male'},
    {'name': 'Simple_Soul', 'status': 'Bas aise hi thodi gupshup', 'gender': 'Female'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SellKaro Gupshup & Gossip Room'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            color: Colors.deepPurple.shade50,
            child: Row(
              children: [
                Icon(Icons.security, color: Colors.deepPurple),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Parde ke peeche rahein! Pehle gupshup karein, pasand aaye toh hi number/details share karein.',
                    style: TextStyle(fontSize: 12, color: Colors.deepPurple.shade900, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: onlineUsers.length,
              itemBuilder: (context, index) {
                final user = onlineUsers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: user['gender'] == 'Male' ? Colors.blue.shade100 : Colors.pink.shade100,
                      child: Icon(
                        Icons.person,
                        color: user['gender'] == 'Male' ? Colors.blue : Colors.pink,
                      ),
                    ),
                    title: Text(
                      user['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user['status']!),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onPressed: () {
                        // Personal Chat Screen par le jayega
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivateChatScreen(partnerName: user['name']!),
                          ),
                        );
                      },
                      child: Text('Chat Karein', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Personal Chat Screen jahan do log aapas mein baat karenge
class PrivateChatScreen extends StatefulWidget {
  final String partnerName;
  PrivateChatScreen({required this.partnerName});

  @override
  _PrivateChatScreenState createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<String> _messages = [
    'Hello! Kaise hain aap?',
    'Sab badhiya, aap sunao kahan se ho?',
    'Main Ahmedabad se hu. Aapki profile dekhi toh socha chat karein.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.partnerName}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.grey.shade200 : Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_messages[index]),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: 'Apna message likhein...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: () {
                    if (_msgController.text.isNotEmpty) {
                      setState(() {
                        _messages.add(_msgController.text);
                        _msgController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
