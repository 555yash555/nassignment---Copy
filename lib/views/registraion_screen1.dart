import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:nassignment/models/lrbutton.dart';
import 'package:nassignment/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nassignment/views/registrarionscreen_2.dart';
import 'package:nassignment/controller/registrycontroller.dart';
import '../controller/registrycontroller.dart';

class RegistrationScreen1 extends StatefulWidget {
  static String id = 'Registration_screen12';
  @override
  _RegistrationScreen1State createState() => _RegistrationScreen1State();
}

class _RegistrationScreen1State extends State<RegistrationScreen1> {
  final _auth = FirebaseAuth.instance;
  final store = FirebaseFirestore.instance;
  bool _saving = false;
  String phonenumber = '';
  String admission_year = '';
  String passout_year = '';
  String college_name = '';
  String name = '';

  final Datacontoller = Get.find<datacontoller>();

  String user = '';
  String docid = '';
  var _formKey = GlobalKey<FormState>();
  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Datacontoller.user.value);
    print(Datacontoller.user.value == 'STUDENT');
  }

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
                  SizedBox(
                    height: 48.0,
                  ),
                  // DropdownButtonFormField(
                  //     validator: (value) {
                  //       if (value == null) {
                  //         return 'Please selct a user type';
                  //       }
                  //       return null;
                  //     },
                  //     decoration: textfield_email_inputdecoration_lr.copyWith(),
                  //     hint: Center(
                  //       child: Text(
                  //         'SELECT A USER TYPE',
                  //         style: (TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w500)),
                  //       ),
                  //     ),
                  //     items: ['STUDENT', 'FACULTY', 'ALLUMNI'].map(
                  //       (val) {
                  //         return DropdownMenuItem<String>(
                  //           value: val,
                  //           child: Text(val),
                  //         );
                  //       },
                  //     ).toList(),
                  //     onChanged: ((value) {
                  //       value = user;
                  //     })),
                  SizedBox(
                    height: 6.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      phonenumber = value;
                    },
                    decoration: textfield_email_inputdecoration_lr.copyWith(
                        hintText: 'enter phonumber'),
                    validator: (value) {
                      if (!(value!.contains('+91')) || value.isEmpty) {
                        return 'Please enter phonenumber with indian country code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: textfield_email_inputdecoration_lr.copyWith(
                        hintText: 'enter name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter something ';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      college_name = value;
                    },
                    decoration: textfield_email_inputdecoration_lr.copyWith(
                        hintText: 'enter colllege name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    enabled: Datacontoller.user.value == 'STUDENT',
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      admission_year = value;
                    },
                    decoration: textfield_email_inputdecoration_lr.copyWith(
                        hintText: 'enter admissison year'),
                    validator: (value) {
                      if (Datacontoller.user.value == 'STUDENT') {
                        if (!(isNumeric(value!) && value.length == 4) ||
                            !(Datacontoller.user.value == 'STUDENT') ||
                            value.isEmpty) {
                          return 'Please enter valid year';
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    enabled: Datacontoller.user.value == 'ALLUMNI',
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      passout_year = value;
                    },
                    decoration: textfield_email_inputdecoration_lr.copyWith(
                        hintText: 'enter passout year'),
                    validator: (value) {
                      if (Datacontoller.user.value == 'ALLUMNI') {
                        if (((!(isNumeric(value!) || value.length == 4)) ||
                            value.isEmpty)) {
                          return 'Please enter correct email format';
                        }
                      }
                      return null;
                    },
                  ),
                  lrbutton(
                      register_button_color,
                      (() async => {
                            if (_formKey.currentState!.validate())
                              {
                                setState(() {
                                  _saving = true;
                                }),
                                Datacontoller.admission_year.value =
                                    admission_year,
                                Datacontoller.passout_year.value = passout_year,
                                Datacontoller.college_name.value = college_name,
                                Datacontoller.name.value = name,
                                Datacontoller.phonenumber.value = phonenumber,
                                // Datacontoller.update_data_base(),
                                setState(() {
                                  _saving = false;
                                }),
                                Navigator.restorablePushNamed(
                                    context, RegistrationScreen2.id)
                              }
                          }),
                      'Next'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
