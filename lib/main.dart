import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'controllers/controller.dart';
import 'screens/dash_board_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyDQ6-SCVo3oXLOR2HjHHiE1-OejQH0vWdo",
        storageBucket: "speatalladmin.appspot.com",
        appId: "1:16462942732:web:f3ca14a6185bc595749429",
        messagingSenderId: "16462942732",
        projectId: "speatalladmin")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: 'SpeatAll Admin Dashboard',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Controller(),
          )

        ],
        child: DashBoardScreen(),
      ),
    );
  }
}