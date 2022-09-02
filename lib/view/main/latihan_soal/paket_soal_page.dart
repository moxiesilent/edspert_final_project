import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/models/network_response.dart';
import 'package:latihan_soal_app/models/paket_soal_list.dart';
import 'package:latihan_soal_app/repository/latihan_soal_api%20copy.dart';

class PaketSoalPage extends StatefulWidget {
  const PaketSoalPage({super.key, required this.id});
  static String route = "paker_soal_page";
  final String id;

  @override
  State<PaketSoalPage> createState() => _PaketSoalPageState();
}

class _PaketSoalPageState extends State<PaketSoalPage> {
  PaketSoalList? paketSoalList;

  getPaketSoal() async {
    final paketResult = await LatihanSoalApi().getPaketSoal(widget.id);
    if (paketResult.status == Status.success) {
      paketSoalList = PaketSoalList.fromJson(paketResult.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaketSoal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: Text(
          "Paket Soal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Paket Soal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: paketSoalList == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 6 / 5,
                      children: List.generate(
                        paketSoalList!.data!.length,
                        (index) {
                          final current = paketSoalList!.data![index];
                          return PaketSoalWidget(
                              data: current);
                        },
                      ).toList(),
                    //   Wrap(
                    //   children: List.generate(
                    //     paketSoalList!.data!.length,
                    //     (index) {
                    //       final current = paketSoalList!.data![index];
                    //       return Container(
                    //         padding: EdgeInsets.all(3),
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         child: PaketSoalWidget(data: current),
                    //       );
                    //     },
                    //   ).toList(),
                    // ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaketSoalWidget extends StatelessWidget {
  const PaketSoalWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final PaketSoalData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.withOpacity(0.2),
            ),
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              R.assets.icNote,
              width: 14,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            data.exerciseTitle!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${data.jumlahDone}/${data.jumlahSoal} Paket Soal",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 9,
              color: R.colors.disable,
            ),
          ),
        ],
      ),
    );
  }
}
