import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/models/mapel_list.dart';
import 'package:latihan_soal_app/view/main/latihan_soal/home_page.dart';
import 'package:latihan_soal_app/view/main/latihan_soal/paket_soal_page.dart';

class MapelPage extends StatelessWidget {
  const MapelPage({super.key, required this.mapel});
  static String route = "mapel_page";

  final MapelList mapel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: ListView.builder(
          itemCount: mapel.data!.length,
          itemBuilder: (context, index) {
            final current = mapel.data![index];
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
      ),
    );
  }
}
