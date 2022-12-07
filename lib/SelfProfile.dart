import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SelfProfilePage extends StatefulWidget {
  SelfProfilePage({required this.Userprofile, Key? key}) : super(key: key);
  final RxList Userprofile;

  @override
  State<SelfProfilePage> createState() => _SelfProfilePageState();
}

class _SelfProfilePageState extends State<SelfProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final users = [].obs;

  void getAllUsers() async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection('users');
    final results = await collection.get();

    final storage = FirebaseStorage.instance;

    for (final document in results.docs) {
      if (document.id == FirebaseAuth.instance.currentUser!.uid) {
        final user = {
          'id': document.id,
          'name': document.data()['name'],
          'picture': await storage.ref('users').child(document.id).getDownloadURL()
        };
        users.add(user);
      }
    }
  }


  @override
  void initState() {
    super.initState();
    getAllUsers();
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: "Mulish",fontSize: 22, color: Colors.black),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        // leading: Icon(),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (ctx, index){
                  final user = users[index];
                  print(user['name']);
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 18),
                          child: Center(
                            child: CircleAvatar(
                                radius: 82,
                                backgroundImage: NetworkImage(user['picture'])),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(user['name'], style: TextStyle(fontSize: 28,color: Colors.black, fontFamily: "Mulish",fontWeight: FontWeight.w800),),
                            const SizedBox(width: 4,),
                            const Icon(Icons.verified, color: Colors.blue,),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(currentUser.phoneNumber!, style: TextStyle(color: Colors.black,fontSize: 18, fontFamily: "Mulish",fontWeight: FontWeight.w600),),
                        const SizedBox(height: 9),
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
                      ]
                  );
                },
              ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: (){},
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.edit),
                              Text("Edit Profile" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                            ],
                          ),
                          color: Colors.white70,
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
                               Icon(Icons.mobile_friendly),
                               Text("Change Number" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                            ],
                          ),
                          color: Colors.white70,
                          height: 50,
                          // minWidth: 300,
                          shape: StadiumBorder(),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: (){},
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.monitor),
                              Text("Info App" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                            ],
                          ),                        color: Colors.white70,
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
                              Icon(Icons.logout),
                              Text("LogOut" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
                            ],
                          ),                        color: Colors.white70,
                          height: 50,
                          minWidth: 300,
                          shape: StadiumBorder(),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        })
      ),
    );
  }
}