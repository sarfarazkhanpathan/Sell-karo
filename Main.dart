import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
import 'home.dart';
import 'sell_vehicles.dart';
import 'sell_property.dart';
import 'matrimony.dart';
import 'sell_business.dart';
import 'sell_furniture_appliances.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SellKaroApp());
}

class SellKaroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SellKaro Super App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // Check if user is already logged in, redirect accordingly
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/sell_vehicle': (context) => SellVehicleScreen(),
        '/sell_property': (context) => SellPropertyScreen(),
        '/matrimony': (context) => MatrimonyScreen(),
        '/sell_business': (context) => SellBusinessScreen(),
        '/sell_furniture': (context) => SellFurnitureAppliancesScreen(),
      },
    );
  }
}
