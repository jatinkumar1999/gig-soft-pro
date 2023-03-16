import 'package:flutter/material.dart';
import 'package:gig_soft_pro/auth/login_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {



  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  final collection = await BoxCollection.open(
    'GigSoftPro', // Name of your database
    {'auth'}, // Names of your boxes
    path:
    directory.path, // Path where to store your boxes (Only used in Flutter / Dart IO)



  );
  await Hive.openBox('authDetail');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
