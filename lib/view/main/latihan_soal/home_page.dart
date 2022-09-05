import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/helpers/preference_helper.dart';
import 'package:latihan_soal_app/models/banner_list.dart';
import 'package:latihan_soal_app/models/mapel_list.dart';
import 'package:latihan_soal_app/models/network_response.dart';
import 'package:latihan_soal_app/models/user_by_email.dart';
import 'package:latihan_soal_app/repository/latihan_soal_api%20copy.dart';
import 'package:latihan_soal_app/view/main/latihan_soal/mapel_page.dart';
import 'package:latihan_soal_app/view/main/latihan_soal/paket_soal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapelList? mapelList;
  BannerList? bannerList;

  getMapel() async {
    final mapelResult = await LatihanSoalApi().getMapel();
    if (mapelResult.status == Status.success) {
      mapelList = MapelList.fromJson(mapelResult.data!);
      setState(() {});
    }
  }

  getBanner() async {
    final bannerResult = await LatihanSoalApi().getBanner();
    if (bannerResult.status == Status.success) {
      bannerList = BannerList.fromJson(bannerResult.data!);
      setState(() {});
    }
  }

  UserData? dataUser;

  Future getUserData() async {
    dataUser = await PreferenceHelper().getUserData();
    setState(() {});
  }

  setupFcm() async {
    final tokenFcm = await FirebaseMessaging.instance.getToken();
    print("token fcm: $tokenFcm");
    // FirebaseMessaging messaging = FirebaseMessaging.instance;

    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMapel();
    getBanner();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildUserHomeProfile(),
              _buildTopBanner(context),
              _buildHomeListMapel(mapelList),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Terbaru",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    bannerList == null
                        ? Container(
                            height: 70,
                            width: double.infinity,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            height: 150,
                            child: ListView.builder(
                              itemCount: bannerList!.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final currentBanner = bannerList!.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      currentBanner.eventImage!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildHomeListMapel(MapelList? list) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 21,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Pilih pelajaran",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MapelPage(mapel: mapelList!);
                      },
                    ),
                  );
                },
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: R.colors.primary,
                  ),
                ),
              )
            ],
          ),
          list == null
              ? Container(
                  height: 70,
                  width: double.infinity,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.data!.length > 3 ? 3 : list.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final current = list.data![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PaketSoalPage(
                                id: current.courseId!,
                              );
                            },
                          ),
                        );
                      },
                      child: MapelWidget(
                        title: current.courseName!,
                        totalPaket: current.jumlahMateri!.toString(),
                        totalDone: current.jumlahDone!.toString(),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Container _buildTopBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: R.colors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 147,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              R.assets.imgHome,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.symmetric(
              // horizontal: 20.0,
              vertical: 15,
            ),
            child: const Text(
              "Mau kerjain latihan soal apa hari ini?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildUserHomeProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ${dataUser?.userName ?? "Nama user"}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            R.assets.icAvatar,
            height: 35,
            width: 35,
          ),
        ],
      ),
    );
  }
}

class MapelWidget extends StatelessWidget {
  const MapelWidget({
    Key? key,
    required this.title,
    required this.totalDone,
    required this.totalPaket,
  }) : super(key: key);

  final String title;
  final String totalDone;
  final String totalPaket;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 21,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 53,
            width: 53,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.colors.grey,
            ),
            child: Image.asset(
              R.assets.icAtom,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "$totalDone/$totalPaket Paket latihan soal",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: R.colors.disable,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Stack(
                  children: [
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: R.colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: R.colors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
