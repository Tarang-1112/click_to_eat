import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/restroAdmin/screens/restroDashboard.dart';
import 'package:click_to_eat/src/restroAdmin/screens/restroRegistration.dart';
import 'package:click_to_eat/src/screens/home.dart';
import 'package:click_to_eat/src/screens/registration.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final restroAdminProvider = Provider.of<RestroAdminProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Center(child: Loading())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/logo.png",
                        width: 240,
                        height: 240,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: authProvider.email,
                          decoration: InputDecoration(
                            hintText: "Emails",
                            border: InputBorder.none,
                            icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: grey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: authProvider.password,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            icon: Icon(Icons.lock_open),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (!await authProvider.signIn()) {
                          _key.currentState!.showSnackBar(
                            SnackBar(content: Text("Login Failed")),
                          );
                          return;
                        } else {
                          if (authProvider.isAdmin == true) {
                            authProvider.cleanControllers();
                            changeScreenReplacement(context, DashboardScreen());
                          } else {
                            authProvider.cleanControllers();
                            changeScreenReplacement(context, Home());
                          }
                          // final SharedPreferences _prefs =
                          //     await SharedPreferences.getInstance();
                          // if (!_prefs.getBool("isAdmin")!) {
                          //   authProvider.cleanControllers();
                          //   changeScreenReplacement(context, Home());
                          // } else {
                          //   restroAdminProvider.clearController();
                          //   changeScreenReplacement(context, DashboardScreen());
                          // }
                        }
                        // authProvider.cleanControllers();
                        // changeScreenReplacement(context, Home());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: purple.shade700,
                          border: Border.all(
                            color: grey,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            bottom: 10,
                            top: 10,
                            right: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                  text: "Login",
                                  size: 22,
                                  colors: white,
                                  weight: FontWeight.normal)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                height: 141,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Register As',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            changeScreen(
                                                context, RegistrationScreen());
                                          },
                                          child: Text(
                                            "Customer",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                            onPressed: () {
                                              changeScreen(context,
                                                  RestroRegistrationScreen());
                                            },
                                            child: Text(
                                              "Restaurant",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                            text: "Register Here",
                            size: 20,
                            colors: black,
                            weight: FontWeight.normal),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
