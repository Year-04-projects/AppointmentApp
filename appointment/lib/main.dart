import 'package:appointment/models/user_model.dart' as model;
import 'package:appointment/provider/userdetailsprovider.dart';
import 'package:appointment/screens/AdminScreens/adminhome.dart';
import 'package:appointment/screens/root_screen.dart';
import 'package:appointment/screens/userScreens/userHome.dart';
import 'package:appointment/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/authscreens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        title: 'My App',
        home: roootScreen(),
      ),
    );
  }
}
