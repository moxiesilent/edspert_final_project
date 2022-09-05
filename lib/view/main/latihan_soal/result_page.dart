import 'package:flutter/material.dart';
import 'package:latihan_soal_app/constants/r.dart';
import 'package:latihan_soal_app/models/network_response.dart';
import 'package:latihan_soal_app/models/result_response.dart';
import 'package:latihan_soal_app/repository/latihan_soal_api%20copy.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.exerciseId}) : super(key: key);
  final String exerciseId;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResultResponse? resultResponse;

  getResult() async {
    final result = await LatihanSoalApi().getResult(widget.exerciseId);
    if (result.status == Status.success) {
      resultResponse = ResultResponse.fromJson(result.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: resultResponse == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Tutup",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Selamat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      "Kamu telah menyelesaikan kuiz ini",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Image.asset(
                      R.assets.imgResult,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      "Nilai kamu :",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      resultResponse!.data!.result!.jumlahScore!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 96,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
