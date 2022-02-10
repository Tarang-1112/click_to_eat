import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/category.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/providers/restaurant.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/screens/home.dart';
import 'package:click_to_eat/src/screens/login.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Click To Eat',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ScreenController(),
    ),
  ));
}

class ScreenController extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
