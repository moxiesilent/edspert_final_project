import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:latihan_soal_app/constants/r.dart';
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
      _controller!.addListener(() {
        setState(() {});
      });
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
      bottomNavigationBar: _controller == null
          ? const SizedBox()
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: R.colors.primary,
                      fixedSize: Size(153, 33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_controller!.index == soalList!.data!.length - 1) {
                        final result = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BottomSheetConfirmation();
                          },
                        );
                        if (result == true) {}
                      } else {
                        _controller!.animateTo(_controller!.index + 1);
                      }
                    },
                    child: Text(
                      _controller?.index == soalList!.data!.length - 1
                          ? "Kumpulin"
                          : "Selanjutnya",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
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
                    padding: const EdgeInsets.all(8),
                    child: TabBarView(
                      controller: _controller,
                      children: List.generate(
                        soalList!.data!.length,
                        (index) => SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Soal no ${index + 1}",
                                style: TextStyle(
                                  color: R.colors.disable,
                                  fontSize: 12,
                                ),
                              ),
                              if (soalList!.data![index].questionTitle != null)
                                Html(
                                  data: soalList!.data![index].questionTitle!,
                                  style: {
                                    "body": Style(
                                      padding: EdgeInsets.zero,
                                    ),
                                    "p": Style(
                                      fontSize: FontSize(12),
                                    )
                                  },
                                ),
                              if (soalList!.data![index].questionTitleImg !=
                                  null)
                                Image.network(
                                    soalList!.data![index].questionTitleImg!),
                              _buildOption(
                                "A",
                                soalList!.data![index].optionA,
                                soalList!.data![index].optionAImg,
                                index,
                              ),
                              _buildOption(
                                "B",
                                soalList!.data![index].optionB,
                                soalList!.data![index].optionBImg,
                                index,
                              ),
                              _buildOption(
                                "C",
                                soalList!.data![index].optionC,
                                soalList!.data![index].optionCImg,
                                index,
                              ),
                              _buildOption(
                                "D",
                                soalList!.data![index].optionD,
                                soalList!.data![index].optionDImg,
                                index,
                              ),
                              _buildOption(
                                "E",
                                soalList!.data![index].optionE,
                                soalList!.data![index].optionEImg,
                                index,
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOption(
    String option,
    String? answer,
    String? answerImg,
    int index,
  ) {
    final answerCheck = soalList!.data![index].studentAnswer == option;
    return GestureDetector(
      onTap: () {
        soalList!.data![index].studentAnswer = option;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: answerCheck ? R.colors.primary : Colors.white,
          border: Border.all(
            width: 1,
            color: R.colors.disable,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              option + ".",
              style: TextStyle(
                color: answerCheck ? Colors.white : Colors.black,
              ),
            ),
            if (answer != null)
              Expanded(
                child: Html(
                  data: answer,
                  style: {
                    "p": Style(
                      color: answerCheck ? Colors.white : Colors.black,
                    )
                  },
                ),
              ),
            if (answerImg != null)
              Expanded(
                child: Image.network(answerImg),
              ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetConfirmation extends StatefulWidget {
  const BottomSheetConfirmation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetConfirmation> createState() =>
      _BottomSheetConfirmationState();
}

class _BottomSheetConfirmationState extends State<BottomSheetConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: R.colors.borderGrey,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Image.asset(R.assets.imgSuccess),
          SizedBox(
            height: 15,
          ),
          Text("Kumpulkan latihan soal sekarang?"),
          Text("Boleh langsung kumpulin dong"),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Nanti dulu"),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Ya"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
