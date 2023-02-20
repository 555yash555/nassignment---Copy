import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:nassignment/models/lrbutton.dart';
import 'package:nassignment/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nassignment/views/registration_screen.dart';
import 'package:nassignment/controller/registrycontroller.dart';
import '../controller/registrycontroller.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'displaypage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen2 extends StatefulWidget {
  static String id = 'RegistrationScreen2';
  @override
  _RegistrationScreen2State createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {
  bool _saving = false;
  File? _imageFile;
  File? _resumeFile;
  XFile? pickedFile;
  FilePickerResult? result;
  final Datacontoller = Get.find<datacontoller>();
  FirebaseStorage storage = FirebaseStorage.instance;

  void onsubmit() async {
    try {
      if (pickedFile != null) {
        Reference reference = await FirebaseStorage.instance
            .ref()
            .child("data")
            .child('${Datacontoller.uid.value}_image');
        await reference.putFile(_imageFile!);
        Datacontoller.profile_photo_link.value =
            await reference.getDownloadURL();

        if (result != null) {
          Reference reference = await FirebaseStorage.instance
              .ref()
              .child("data")
              .child('${Datacontoller.uid.value}_resume');
          await reference.putFile(_imageFile!);
          Datacontoller.profile_photo_link.value =
              await reference.getDownloadURL();
        }

        Datacontoller.update_data_base();
        Navigator.pushNamed(context, ProfilePage.id);
      } else {
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
                        'please select a image first',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    actions: [
                      Center(
                        child: lrbutton(login_button_color, (() {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        }), "GO BACK"),
                      )
                    ],
                  )));
            }));
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
                      'some error occure3d retry',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  actions: [
                    Center(
                      child: lrbutton(login_button_color, (() {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      }), "GO BACK"),
                    )
                  ],
                )));
          }));
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    }
  }

  Future<void> _pickResume() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _resumeFile = File((result?.files.single.path)!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _imageFile != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: FileImage(_imageFile!),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: CircleAvatar(
                            radius: 50.0,
                            child: const Icon(Icons.person),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5.0,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: (() {
                        _pickImage(ImageSource.gallery);
                      }),
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'pick image',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _resumeFile != null
                      ? Text(
                          _resumeFile!.path,
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'No resume selected',
                          textAlign: TextAlign.center,
                        ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5.0,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: (() {
                        _pickResume();
                      }),
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'pick resume',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Material(
                    elevation: 5.0,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: (() {
                        setState(() {
                          _saving = true;
                        });
                        onsubmit();
                        setState(() {
                          _saving = false;
                        });
                      }),
                      minWidth: 300.0,
                      height: 42.0,
                      child: Text(
                        'SUBMIT',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:nassignment/components/lrbuttonfuture.dart';

// class RegistrationScreen2 extends StatefulWidget {
//   static String id = 'Registration_screen11';
//   @override
//   _RegistrationScreen2State createState() => _RegistrationScreen2State();
// }

// class _RegistrationScreen2State extends State<RegistrationScreen2> {
//   File? _imageFile;
//   File? _resumeFile;

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     setState(() {
//       _imageFile = File(pickedFile!.path);
//     });
//   }

//   Future<void> _pickResume() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         _resumeFile = File(result.files.single.path.toString());
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile != null
//                 ? CircleAvatar(
//                     radius: 50.0,
//                     backgroundImage: FileImage(_imageFile!),
//                   )
//                 : CircleAvatar(
//                     radius: 50.0,
//                     child: Icon(Icons.person),
//                   ),
//             SizedBox(height: 20),
//             lrbuttonfuture(
//               login_button_color,
//               _pickImage(ImageSource.gallery),
//               'Pick Image',
//             ),
//             SizedBox(height: 20),
//             _resumeFile != null
//                 ? Text(
//                     _resumeFile!.path,
//                     textAlign: TextAlign.center,
//                   )
//                 : Text(
//                     'No resume selected',
//                     textAlign: TextAlign.center,
//                   ),
//             SizedBox(height: 20),
//             lrbuttonfuture(
//               login_button_color,
//               _pickResume(),
//               'Pick Image',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
