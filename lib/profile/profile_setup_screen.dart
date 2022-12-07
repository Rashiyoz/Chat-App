import 'dart:io';
import 'dart:math';
import 'background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chating/home/home.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final controller = TextEditingController();
  RxString nameReader =''.obs;
  final selectedImage = ''.obs;

  void pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image?.path == null) {
      return;
    }

    selectedImage.value = image!.path;
  }

  void saveProfile() async {
    final name = controller.text;
    if (name.isEmpty || selectedImage.value.isEmpty) {
      return;
    }

    final picture = File(selectedImage.value);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance;
    final collection = db.collection('users');
    final document = collection.doc(uid);
    await document.set({
      'name': name,
    });

    final storage = FirebaseStorage.instance;
    await storage.ref('users').child(uid).putFile(picture);


    Get.offAll(HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Text(
                  "PORFILE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                      fontSize: 32
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            GestureDetector(
                onTap: () => pickImage(),
                child: Obx(() {
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: selectedImage.value.isNotEmpty
                        ? FileImage(File(selectedImage.value))
                        : null,
                    child: selectedImage.value.isEmpty
                        ? const Icon(Icons.person, size: 32)
                        : null,
                  );
                })),
            SizedBox(height: size.height * 0.03),
            Obx(() {
              if(nameReader.value.isNotEmpty){
                return Text(nameReader.value, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black),);
              }
              else return Text("Name Here..",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black),);
            }),
            SizedBox(height: size.height * 0.01),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: controller,
                onChanged: (val){
                  nameReader.value = val;
                },
                decoration: InputDecoration(
                    labelText: "Name"
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: MaterialButton(
                onPressed: () {
                  saveProfile();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 2,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                          colors: [
                            Colors.indigoAccent,
                            Colors.indigo
                          ]
                      )
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "SAVE",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
