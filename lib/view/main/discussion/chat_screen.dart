import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan_soal_app/constants/r.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  late CollectionReference chat;
  late QuerySnapshot chatData;
  // List<QueryDocumentSnapshot>? listChat;

  // getDataFromFirebase() async {
  //   chatData = await FirebaseFirestore.instance
  //       .collection("room")
  //       .doc("kimia")
  //       .collection("chat")
  //       .get();
  //   // listChat = chatData.docs;
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    chat = FirebaseFirestore.instance
        .collection("room")
        .doc("kimia")
        .collection("chat");

    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: Text("Diskusi Soal"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: chat
                    .orderBy(
                      "time",
                    )
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.reversed.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      final currentChat = snapshot.data!.docs.reversed.toList()[index];
                      final currentDate =
                          (currentChat['time'] as Timestamp?)?.toDate();
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: user.uid == currentChat['uid']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentChat['nama'],
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff5200ff),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: user.uid == currentChat['uid']
                                    ? Colors.white
                                    : Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: user.uid == currentChat['uid']
                                      ? Radius.zero
                                      : Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  topLeft: user.uid == currentChat['uid']
                                      ? Radius.circular(10)
                                      : Radius.zero,
                                ),
                              ),
                              child: Text(
                                currentChat['content'],
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              currentDate == null
                                  ? ""
                                  : DateFormat.Hm().format(currentDate),
                              style: TextStyle(
                                fontSize: 10,
                                color: R.colors.disable,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: R.colors.primary,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Ketuk untuk menulis pesan..",
                                hintStyle: TextStyle(
                                  color: R.colors.disable,
                                ),
                                suffixIcon: Icon(
                                  Icons.photo_camera,
                                  color: R.colors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (textController.text.isEmpty) {
                        return;
                      }
                      print(textController.text);
                      try {
                        final chatContent = {
                          "nama": user.displayName,
                          "uid": user.uid,
                          "content": textController.text,
                          "email": user.email,
                          "photo": user.photoURL,
                          "time": FieldValue.serverTimestamp(),
                        };
                        chat
                            .add(chatContent)
                            .whenComplete(() => textController.clear());
                      } catch (e, s) {
                        print(e);
                        print(s);
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: R.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
