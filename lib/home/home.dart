import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chating/conversation_screen.dart';
import 'package:chating/find_screen.dart';
import 'package:intl/intl.dart';
import 'package:chating/SelfProfile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final users = [].obs;
class _HomeScreenState extends State<HomeScreen> {
  final chats = [].obs;
  final loading = true.obs;



  void getAllUsers() async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection('users');
    final results = await collection.get();

    final storage = FirebaseStorage.instance;

    for (final document in results.docs) {
      if (document.id == FirebaseAuth.instance.currentUser!.uid) {
        continue;
      }
      final user = {
        'id': document.id,
        'name': document.data()['name'],
        'picture': await storage.ref('users').child(document.id).getDownloadURL()
      };

      users.add(user);
    }
  }


  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final db = FirebaseFirestore.instance;
    final usersCol = db.collection('users');

    usersCol.doc(uid).collection('chats').snapshots().listen((event) async {
      chats.clear();
      for (var doc in event.docs) {
        final user = await usersCol.doc(doc.id).get();
        chats.add({
          'id': doc.id,
          'name': user.data()?['name'] ?? 'Null',
          'picture': await FirebaseStorage.instance.ref('users').child(doc.id).getDownloadURL(),
          'lastMessage': doc.data()['lastMessage']
        });
      }
      loading.value = false;
    });
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Obx(() {
        if (loading.isTrue) {
          return Center(child: CircularProgressIndicator(color: Colors.white,));
        } else {
          return SafeArea(
            child: Stack(
              children: [
                _top(),
                Positioned(
                  bottom: -10,
                  right: 0,
                  left: 0,
                  top: 200,
                  child: _buildList()
                )
              ],
            ),
          );
        }
      }),
    );
  }

  _buildList() {
    return Obx(() {
      if (chats.isEmpty) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            color: Colors.white,
          ),
          child: Center(child: Text('No Chats!')),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            color: Colors.white,
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: chats.length,
            itemBuilder: (ctx, index) {
              final chat = chats[index];
              final id = chat['id'];
              final lastMessage = chat['lastMessage'];

              Timestamp t = lastMessage['date'];
              final currentTime = Timestamp.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
              final timeStamps = lastMessage['date'] == null ? currentTime : lastMessage['date'] as Timestamp;

              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(chat['picture']!),
                ),
                onTap: () => Get.to(ConversationScreen(user: chat)),
                title: Row(
                  children: [
                    Text(chat['name']!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),),
                    SizedBox(width: 10,),
                    Icon(Icons.verified, color: Colors.blue,)
                  ],
                ),
                subtitle: lastMessage['message'] == null ? Text("") : Text(lastMessage['message']!, style: TextStyle(fontSize: 16),) ,
                trailing: Text(DateFormat.yMMMd().format(timeStamps.toDate()),),
              );
            },
          ),
        );
      }
    });
  }
}

  _top() {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               'Chat with \nyour friends',
               style: TextStyle(fontFamily: "Mulish",
                   fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
             ),
             Padding(
               padding: const EdgeInsets.only(right: 18.0),
               child: IconButton(
                 onPressed: (){
                   Get.to(SelfProfilePage(Userprofile: users,));
                 },
                 icon: const Icon(Icons.more_vert, color: Colors.white,size: 26,),
               ),
             )
           ],
         ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
             Obx(() {
               return Expanded(
                 child: Container(
                   height: 100,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     shrinkWrap: true,
                     itemCount: users.length,
                     itemBuilder: (ctx, index) {
                       final user = users[index];
                       final name = user['name'] ?? '';
                       final picture = user['picture'];
                       return GestureDetector(
                         onTap: () {
                           Get.to(ConversationScreen(user: user));
                         },
                         child: Container(
                           padding: EdgeInsets.only(left: 9),
                           child: CircleAvatar(
                             radius: 30,
                             backgroundImage: NetworkImage(picture),
                           ),
                         ),
                       );
                     },
                   ),
                 ),
               );
             })
            ],
          ),
        ],
      ),
    );
  }
