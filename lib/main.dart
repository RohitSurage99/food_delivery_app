import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:fooddeliveryapp2/admin/home_admin.dart';
// import 'package:fooddeliveryapp2/pages/onboard.dart';
import 'package:fooddeliveryapp2/widget/app_constant.dart';
import 'admin/admin_login.dart';
import 'pages/onboard.dart';

// import 'package:fooddeliveryapp2/pages/signup.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'admin/admin_login.dart';
// import 'package:fooddeliveryapp/admin/admin_login.dart';
// import 'package:fooddeliveryapp/admin/home_admin.dart';
// import 'package:fooddeliveryapp/pages/bottomnav.dart';
// import 'package:fooddeliveryapp/pages/home.dart';
// import 'package:fooddeliveryapp/pages/login.dart';
// import 'package:fooddeliveryapp/pages/onboard.dart';
//
// import 'package:fooddeliveryapp/pages/signup.dart';
// import 'package:fooddeliveryapp/widget/app_constant.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: HomeAdmin());
        home: Onboard());
  }
}
