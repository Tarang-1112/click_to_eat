import 'dart:async';
import 'package:click_to_eat/src/helpers/user.dart';
import 'package:click_to_eat/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth? auth;
  User? user;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserModel? userModel = UserModel(name: "Loading", email: "Loading", id: "");
  UserServices _userServices = UserServices();
  Status status = Status.Uninitialized;

  //getters
  // UserModel? get userModel => _userModel;
  // Status get status => _status;
  // User get user => _user!;

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  UserProvider.initialize() : auth = FirebaseAuth.instance {
    auth!.authStateChanges().listen((event) {
      _onStateChanged(FirebaseAuth.instance.currentUser);
    });
  }

  Future<bool> signIn() async {
    try {
      status = Status.Authenticating;
      notifyListeners();
      await auth!.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<bool> singUp() async {
    try {
      status = Status.Authenticating;
      notifyListeners();
      await auth!
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firebaseFirestore.collection("users").doc(result.user!.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user!.uid,
          // 'likedFood': [],
          // 'likedRestaurant': [],
        });
      });
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future signOut() {
    auth!.signOut();
    status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void cleanControllers() {
    email.text = "";
    password.text = "";
    name.text = "";
  }

  Future<void> _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      status = Status.Unauthenticated;
    } else {
      user = firebaseUser;
      status = Status.Authenticated;
      //final uid = FirebaseAuth.instance.currentUser!.uid;
      userModel = await _userServices.getUserById(user!.uid);
    }
    notifyListeners();
  }

//general methods
  bool _onError(String error) {
    status = Status.Unauthenticated;
    notifyListeners();
    print("Error :  $error");
    return false;
  }
}
