import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Akun Saya"),
        actions: [
          TextButton(
            onPressed: () {},
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
      body: SingleChildScrollView(
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
                      children: const [
                        Text(
                          "Nama User",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Nama Sekolah User",
                          style: TextStyle(
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
              padding: EdgeInsets.symmetric(
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
                    "Nama Lengkap User",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
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
                    "Nama Lengkap User",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
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
                    "Nama Lengkap User",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
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
                    "Nama Lengkap User",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
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
                    "Nama Lengkap User",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
