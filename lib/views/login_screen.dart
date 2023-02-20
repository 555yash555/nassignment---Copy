import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassignment/models/lrbutton.dart';
import 'package:nassignment/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nassignment/views/displaypage.dart';
import 'package:nassignment/controller/registrycontroller.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late var newuser;
  final Datacontoller = Get.put(datacontoller());
  FirebaseFirestore _store = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  )),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: textfield_email_inputdecoration_lr),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: textfield_password_inputdecoration_lr),
              SizedBox(
                height: 24.0,
              ),
              lrbutton(login_button_color, (() async {
                setState(() {
                  _saving = true;
                });
                try {
                  newuser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  String uid = await _auth.currentUser!.uid;
                  print(uid);
                  var collection = _store.collection('user');
                  var docSnapshot = await collection.doc(uid).get();
                  if (docSnapshot.exists) {
                    Map<String, dynamic>? data = docSnapshot.data();
                    print(data);
                    Datacontoller.admission_year.value =
                        data?['admission_year'];
                    Datacontoller.passout_year.value =
                        await data?['passout_year'];
                    Datacontoller.college_name.value =
                        await data?['college_name'];
                    Datacontoller.name.value = await data?['name'];
                    Datacontoller.phonenumber.value =
                        await data?['phonenumber'];
                    Datacontoller.user.value = await data?['user'];
                    Datacontoller.email.value = data?['email'];
                    Datacontoller.uid.value = await data?['uid'];
                    Datacontoller.profile_photo_link.value =
                        await data?['profile_photo_link'];
                    Datacontoller.resume_link.value =
                        await data?['resume_link'];
                  }

                  if (newuser != null) {
                    setState(() {
                      _saving = false;
                    });

                    Navigator.restorablePushNamed(context, ProfilePage.id);
                  } else {
                    Navigator.restorablePushNamed(context, LoginScreen.id);
                  }
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: (AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              clipBehavior: Clip.antiAlias,
                              backgroundColor: Colors.black,
                              title: Center(
                                child: Text(
                                  'USER NOT REGISTERED PLEASE REGISTER FIRST',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              actions: [
                                Center(
                                  child: lrbutton(login_button_color, (() {
                                    Navigator.pushNamed(
                                        context, RegistrationScreen.id);
                                  }), "GO TO REGISTRATION SCREEN"),
                                )
                              ],
                            )));
                      }));
                }
              }), 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
