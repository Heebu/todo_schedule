import 'package:flutter/material.dart';
import 'IntroScreen/splash_screen.dart';
import 'MainScreen/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://rgkoigwaveaadcwqdjqi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJna29pZ3dhdmVhYWRjd3FkanFpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE0NjkyMzMsImV4cCI6MTk5NzA0NTIzM30.WxeEKFo0CPufWk5DklaACCaXh7B4cP48WfO3AjQClcA',
  );

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(),
    );
  }
}
