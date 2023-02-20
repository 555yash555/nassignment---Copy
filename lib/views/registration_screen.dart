import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:nassignment/models/lrbutton.dart';
import 'package:nassignment/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nassignment/views/registraion_screen1.dart';
import 'package:nassignment/controller/registrycontroller.dart';
import '../controller/registrycontroller.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'Registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  bool _saving = false;
  late String email;
  late String password;
  late var newuser;
  final Datacontoller = Get.put(datacontoller());

  String user = '';
  String docid = '';
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'Please selct a user type';
                        }
                        return null;
                      },
                      decoration: textfield_email_inputdecoration_lr.copyWith(),
                      hint: Center(
                        child: Text(
                          'SELECT A USER TYPE',
                          style: (TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                        ),
                      ),
                      items: ['STUDENT', 'FACULTY', 'ALLUMNI'].map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: ((value) {
                        user = value!;
                      })),
                  SizedBox(
                    height: 6.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: textfield_email_inputdecoration_lr.copyWith(),
                    validator: (value) {
                      if (!(value!.contains('@')) || value.isEmpty) {
                        return 'Please enter correct email format';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value!.length < 8 || value.isEmpty) {
                          return 'Please enter atleast 8 digits';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: textfield_password_inputdecoration_lr),
                  SizedBox(
                    height: 24.0,
                  ),
                  lrbutton(
                      register_button_color,
                      (() async => {
                            if (_formKey.currentState!.validate())
                              {
                                setState(() {
                                  _saving = true;
                                }),
                                newuser = '',
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password),
                                if (newuser != null)
                                  {
                                    Datacontoller.user.value = user,
                                    Datacontoller.email.value = email,
                                    Datacontoller.uid.value =
                                        await _auth.currentUser!.uid,
                                    setState(() {
                                      _saving = false;
                                    }),
                                    print(Datacontoller.user.value),
                                    Navigator.restorablePushNamed(
                                        context, RegistrationScreen1.id)
                                  }
                              }
                          }),
                      'Register'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
