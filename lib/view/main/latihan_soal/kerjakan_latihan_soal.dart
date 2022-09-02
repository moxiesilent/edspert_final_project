import 'package:flutter/material.dart';
import 'package:latihan_soal_app/models/kerjakan_soal_list.dart';
import 'package:latihan_soal_app/models/network_response.dart';
import 'package:latihan_soal_app/repository/latihan_soal_api%20copy.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage>
    with SingleTickerProviderStateMixin {
  KerjakanSoalList? soalList;
  TabController? _controller;

  getQuestionList() async {
    final result = await LatihanSoalApi().postQuestionList(widget.id);
    if (result.status == Status.success) {
      soalList = KerjakanSoalList.fromJson(result.data!);
      _controller = TabController(
        length: soalList!.data!.length,
        vsync: this,
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Soal"),
      ),
      //tombol selanjutnya atau submit
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("Selanjutnya"),
            ),
          ],
        ),
      ),
      body: soalList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                //tab bar soal
                Container(
                  child: TabBar(
                    controller: _controller,
                    tabs: List.generate(
                      soalList!.data!.length,
                      (index) => Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                //tab view soal dan pilihan jawaban
                Expanded(
                  child: Container(
                    child: TabBarView(
                      controller: _controller,
                      children: List.generate(
                        soalList!.data!.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Soal no ${index + 1}",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            if (soalList!.data![index].questionTitle != null)
                              Text(
                                soalList!.data![index].questionTitle!,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            if (soalList!.data![index].questionTitleImg != null)
                              Image.network(
                                  soalList!.data![index].questionTitleImg!),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
