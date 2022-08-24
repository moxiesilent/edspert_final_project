import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String route = "register_page";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Gender { lakilaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  String gender = "laki-laki";
  List<String> kelas = ["10", "11", "12"];
  String selectedKelas = "10";

  onTapGender(Gender g) {
    if (g == Gender.lakilaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Yuk isi data diri',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InputRegisterTextfield(
              hintText: "example@gmail.com",
              title: "Email",
            ),
            const InputRegisterTextfield(
              hintText: "contoh : John Doe",
              title: "Nama Lengkap",
            ),
            const Text(
              "Jenis Kelamin",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
            const InputRegisterTextfield(
              hintText: "nama sekolah",
              title: "Nama Sekolah",
            )
          ],
        ),
      ),
    );
  }
}

class InputRegisterTextfield extends StatelessWidget {
  const InputRegisterTextfield({
    Key? key,
    required this.title,
    required this.hintText,
  }) : super(key: key);
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: R.colors.borderGrey,
              )),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: R.colors.hintTextColor,
                )),
          ),
        ),
      ],
    );
  }
}
