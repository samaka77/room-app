import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_app/auth/login.dart';
import 'package:room_app/provider/favorite_provider.dart';


import 'package:room_app/screens/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDgvVeZEFwIR5d2IbNQXo-ZeH-VHr3dNZU",
        authDomain: "hotelapp-34466.firebaseapp.com",
        projectId: "hotelapp-34466",
        storageBucket: "hotelapp-34466.firebasestorage.app",
        messagingSenderId: "968871741832",
        appId: "1:968871741832:web:375710edfeac56be24923d",
        measurementId: "G-VHSDZDL0FH",
      ),
    );
  }
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://bdoiadnxfytlgwiqzrrx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJkb2lhZG54Znl0bGd3aXF6cnJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA1OTQ2MDcsImV4cCI6MjA1NjE3MDYwN30.Gqlmx4qljGoucnr9WfFzIxXcpgojkquYJsRB5zGj2Rk',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider())
      ],
      child: MaterialApp(
        title: 'Hotels App',
        debugShowCheckedModeBanner: false,
      
        home: 
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainScreen();
            } else {
              return Login();
            }
          },
        ),
      ),
    );
  }
}
