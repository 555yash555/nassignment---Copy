import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class datacontoller extends GetxController {
  FirebaseFirestore _store = FirebaseFirestore.instance;
  RxString user = ''.obs;
  RxString uid = ''.obs;
  RxString email = ''.obs;

  RxString phonenumber = ''.obs;
  RxString admission_year = ''.obs;
  RxString passout_year = ''.obs;
  RxString college_name = ''.obs;
  RxString name = ''.obs;
  RxString resume_link = ''.obs;
  RxString profile_photo_link = ''.obs;

  void update_data_base() async {
    await _store.collection('user').doc(uid.value).set({
      'uid': uid.value,
      'user': user.value,
      'email': email.value,
      'phonenumber': phonenumber.value,
      'admission_year': admission_year.value,
      'passout_year': passout_year.value,
      'college_name': college_name.value,
      'name': name.value,
      'resume_link': resume_link.value,
      'profile_photo_link': profile_photo_link.value,
    });
  }
}
