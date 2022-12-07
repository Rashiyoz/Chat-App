import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileView extends StatefulWidget {
   ProfileView({required this.Userprofile, Key? key}) : super(key: key);
  final Map Userprofile;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  final Block = false.obs;


  // void block() async {
  //   final receiver = FirebaseAuth.instance.currentUser!.uid;
  //   final String sender = widget.Userprofile['id'];
  //
  //   final db = FirebaseFirestore.instance;
  //   final usersCol = db.collection('users');
  //
  //   usersCol
  //       .doc(receiver)
  //       .collection('chats')
  //       .doc(sender)
  //       .set({'Block': true}, SetOptions(merge: true));
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: "Mulish",fontSize: 22, color: Colors.black),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        // leading: Icon(),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
        body: SafeArea(
          child: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 18),
                    child: Center(
                      child: CircleAvatar(
                          radius: 82,
                          backgroundImage: NetworkImage(widget.Userprofile['picture']!)),
                        ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.Userprofile['name']!, style: TextStyle(fontSize: 28, fontFamily: "Mulish",fontWeight: FontWeight.w800),),
                      const SizedBox(width: 4,),
                      const Icon(Icons.verified, color: Colors.blue,),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // const SizedBox(
                  //   width: 80,
                  //   child: Divider(
                  //     color: Colors.indigo,
                  //     height: 14,
                  //     thickness: 3,
                  //     indent: 1.0,
                  //     endIndent: 1.0,
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      // height: 500,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48), topRight: Radius.circular(45)),
                        color: Colors.indigo,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            MaterialButton(
                              onPressed: (){
                                setState(() {
                                });
                              },
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const[
                                  Icon(Icons.block),
                                  Text("Block User" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                                ],
                              ),                            color: Colors.white70,
                              height: 50,
                              minWidth: 300,
                              shape: StadiumBorder(),
                            ),const SizedBox(height: 20),
                            MaterialButton(
                              onPressed: (){},
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const[
                                  Icon(Icons.unpublished),
                                  Text("UnBlock User" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                                ],
                              ),                            color: Colors.white70,
                              height: 50,
                              minWidth: 300,
                              shape: StadiumBorder(),
                            ),
                            const SizedBox(height: 20),
                            MaterialButton(
                              onPressed: (){},
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const[
                                  Icon(Icons.report),
                                  Text("Report" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                                ],
                              ),                            color: Colors.white70,
                              height: 50,
                              minWidth: 300,
                              shape: StadiumBorder(),
                            ),
                            const SizedBox(height: 20),
                            MaterialButton(
                              onPressed: (){},
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const[
                                  Icon(Icons.volume_mute_outlined),
                                  Text("Mute" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                                ],
                              ),                              color: Colors.white70,
                              height: 50,
                              minWidth: 300,
                              shape: StadiumBorder(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ]
                ),
          ),
        ),
        );
    }
}