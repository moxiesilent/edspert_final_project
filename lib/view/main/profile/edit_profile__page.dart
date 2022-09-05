import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/helpers/preference_helper.dart';
import 'package:latihan_soal_app/helpers/user_email.dart';
import 'package:latihan_soal_app/models/network_response.dart';
import 'package:latihan_soal_app/models/user_by_email.dart';
import 'package:latihan_soal_app/repository/auth_api.dart';
import 'package:latihan_soal_app/view/login_page.dart';
import 'package:latihan_soal_app/view/main_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static String route = "register_page";

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

enum Gender { lakilaki, perempuan }

class _EditProfilePageState extends State<EditProfilePage> {
  List<String> kelas = ["10", "11", "12"];
  String gender = "laki-laki";
  String selectedKelas = "10";

  final emailController = TextEditingController();
  final namaController = TextEditingController();
  final sekolahController = TextEditingController();

  onTapGender(Gender g) {
    if (g == Gender.lakilaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  initDataUser() async {
    emailController.text = UserEmail.getUserEmail()!;
    // namaController.text = UserEmail.getUserDisplayName()!;
    final dataUser = await PreferenceHelper().getUserData();
    namaController.text = dataUser!.userName!;
    sekolahController.text = dataUser.userAsalSekolah!;
    gender = dataUser.userGender!;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: R.colors.primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Edit Akun',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ButtonLogin(
            radius: 8,
            onTap: () async {
              final json = {
                "email": emailController.text,
                "nama_lengkap": namaController.text,
                "nama_sekolah": sekolahController.text,
                "kelas": selectedKelas,
                "gender": gender,
                "foto": UserEmail.getUserPhotoUrl(),
              };

              final result = await AuthApi().postRegister(json);
              if (result.status == Status.success) {
                final registerResult = UsersByEmail.fromJson(result.data!);
                if (registerResult.status == 1) {
                  await PreferenceHelper().setUserData(registerResult.data!);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainPage.route, (context) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(registerResult.message!),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Terjadi kesalahan silahkan ulangi kembali."),
                  ),
                );
              }
            },
            backgroundColor: R.colors.primary,
            borderColor: R.colors.primary,
            child: const Text(
              "Perbaharui Akun",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileTextfield(
                enabled: false,
                controller: emailController,
                hintText: "example@gmail.com",
                title: "Email",
              ),
              EditProfileTextfield(
                controller: namaController,
                hintText: "contoh : John Doe",
                title: "Nama Lengkap",
              ),
              Text(
                "Jenis Kelamin",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: R.colors.disable,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Laki-laki"
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: R.colors.borderGrey,
                            ),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.lakilaki);
                        },
                        child: Text(
                          "Laki-laki",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Laki-laki"
                                ? Colors.white
                                : R.colors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: gender == "Perempuan"
                              ? R.colors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: R.colors.borderGrey,
                            ),
                          ),
                        ),
                        onPressed: () {
                          onTapGender(Gender.perempuan);
                        },
                        child: Text(
                          "Perempuan",
                          style: TextStyle(
                            fontSize: 14,
                            color: gender == "Perempuan"
                                ? Colors.white
                                : R.colors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Kelas",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: R.colors.disable,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: R.colors.borderGrey,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedKelas,
                    items: kelas
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (String? val) {
                      selectedKelas = val!;
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              EditProfileTextfield(
                controller: sekolahController,
                hintText: "nama sekolah",
                title: "Nama Sekolah",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileTextfield extends StatelessWidget {
  const EditProfileTextfield({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: R.colors.disable,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            enabled: enabled,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: R.colors.hintTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
