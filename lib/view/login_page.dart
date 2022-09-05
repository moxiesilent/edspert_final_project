import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/helpers/preference_helper.dart';
import 'package:latihan_soal_app/models/network_response.dart';
import 'package:latihan_soal_app/repository/auth_api.dart';
import 'package:latihan_soal_app/models/user_by_email.dart';
import 'package:latihan_soal_app/view/main/latihan_soal/home_page.dart';
import 'package:latihan_soal_app/view/main_page.dart';
import 'package:latihan_soal_app/view/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String route = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                R.strings.login,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(R.assets.imageLogin),
            const SizedBox(
              height: 35,
            ),
            Text(
              R.strings.welcome,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              R.strings.loginDesc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: R.colors.subtitle,
              ),
            ),
            const Spacer(),
            ButtonLogin(
              onTap: () async {
                print("masuk login");
                try {
                  await signInWithGoogle();
                } catch (e, s) {
                  print(e);
                  print(s);
                }

                print("masuk login 2");

                final user = FirebaseAuth.instance.currentUser;
                print(user);
                if (user != null) {
                  final dataUser = await AuthApi().getUserByEmail();
                  if (dataUser.status == Status.success) {
                    final data = UsersByEmail.fromJson(dataUser.data!);
                    if (data.status == 1) {
                      await PreferenceHelper().setUserData(data.data!);
                      Navigator.of(context).pushNamed(MainPage.route);
                    } else {
                      Navigator.of(context).pushNamed(RegisterPage.route);
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Gagal Masuk"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                // Navigator.of(context).pushNamed(RegisterPage.route);
              },
              backgroundColor: Colors.white,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icGoogle),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    R.strings.loginWithGoogle,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: R.colors.blackLogin,
                    ),
                  ),
                ],
              ),
            ),
            ButtonLogin(
              onTap: () async {
                Navigator.of(context).pushNamed(RegisterPage.route);
              },
              backgroundColor: Colors.black,
              borderColor: R.colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(R.assets.icApple),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    R.strings.loginWithApple,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.borderColor,
    required this.onTap,
    this.radius,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final Function()? onTap;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 12,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          elevation: 0,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular( radius ?? 25),
            side: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
