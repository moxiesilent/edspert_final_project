import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/helpers/preference_helper.dart';
import 'package:latihan_soal_app/models/user_by_email.dart';
import 'package:latihan_soal_app/view/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData? user;
  getUser() async {
    final data = await PreferenceHelper().getUserData();
    user = data;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Akun Saya"),
        actions: [
          TextButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginPage.route,
                (route) => false,
              );
            },
            child: Text(
              "Edit",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),

              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: R.colors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(9),
                        bottomRight: Radius.circular(9),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 28,
                      bottom: 60,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user!.userName!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user!.userAsalSekolah!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          R.assets.icAvatar,
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 18,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Identitas Diri"),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Nama Lengkap",
                          style: TextStyle(
                            color: R.colors.disable,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userName!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                            color: R.colors.disable,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userEmail!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            color: R.colors.disable,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userGender!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Kelas",
                          style: TextStyle(
                            color: R.colors.disable,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.kelas ?? "",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Asal sekolah",
                          style: TextStyle(
                            color: R.colors.disable,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          user!.userAsalSekolah!,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.route,
                        (route) => false,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: const ListTile(
                        title: Text(
                          "Keluar",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
