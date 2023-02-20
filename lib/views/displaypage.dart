import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nassignment/controller/registrycontroller.dart';

class ProfilePage extends StatelessWidget {
  static String id = 'chaman';
  final Datacontoller = Get.find<datacontoller>();

  @override
  Widget build(BuildContext context) {
    String name = Datacontoller.name.value;
    String phoneNumber = Datacontoller.phonenumber.value;
    String admissionYear = Datacontoller.admission_year.value;
    String passoutYear = Datacontoller.passout_year.value;
    String collegeName = Datacontoller.college_name.value;
    String userType = Datacontoller.user.value;
    String resumeLink = Datacontoller.resume_link.value;
    String profilePhoto = Datacontoller.profile_photo_link.value;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profilePhoto),
              ),
              SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Phone number: $phoneNumber',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Admission year: $admissionYear',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Passout year: $passoutYear',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'College name: $collegeName',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'User type: $userType',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Resume link: $resumeLink',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
