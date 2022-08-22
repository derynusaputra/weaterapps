import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weaterdery/app/data/sizing.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizes = Sizing();
    print('${Get.width}x${Get.height}');
    var now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    // var format = new DateFormat('yyyy-MM-dd');
    String time = DateFormat.yMMMEd().format(now);
    var arg = Get.arguments;
    return Scaffold(
      backgroundColor: Color(0xff014F69),
      appBar: AppBar(
        backgroundColor: Color(0xff014F69),
        elevation: 0,
        title: Column(
          children: [
            Text('${arg[1]}'),
            Text('${time}',
                style: TextStyle(
                  fontSize: sizes.widthS(12, size),
                )),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: controller.getDataCuaca(arg[1]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    var data = snapshot.data as Map;
                    // print("${snapshot.data}data snap");

                    var icon = data["weather"][0]["icon"];

                    return Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: sizes.widthS(10, size)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Selamat Sore, Dery",
                                      style: TextStyle(
                                          fontSize: sizes.widthS(18, size),
                                          color: Colors.white)),
                                  SizedBox(
                                    height: sizes.heightS(15, size),
                                  ),
                                  Text("${data["main"]["temp"]} °c",
                                      style: TextStyle(
                                          fontSize: sizes.widthS(50, size),
                                          color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Clouds',
                                      style: TextStyle(
                                          fontSize: sizes.widthS(18, size),
                                          color: Colors.white)),
                                  Image.network(
                                      "http://openweathermap.org/img/wn/${icon}@2x.png")
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: sizes.widthS(360, size),
                          height: sizes.heightS(117, size),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                sizes.heightS(15, size),
                              ),
                              color: Color(0xffF3F3F1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_pin_circle_outlined),
                                  Text("${data["main"]["humidity"]} %",
                                      style: TextStyle(
                                          fontSize: sizes.widthS(18, size),
                                          color: Color(0xff014F69))),
                                  Text("Humidity"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timelapse_sharp),
                                  Text("${data["main"]["pressure"]} hps",
                                      style: TextStyle(
                                          fontSize: sizes.widthS(18, size),
                                          color: Color(0xff014F69))),
                                  Text("Pressure"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud),
                                  Text("${data["clouds"]["all"]} %",
                                      style: TextStyle(
                                          fontSize: sizes.widthS(18, size),
                                          color: Color(0xff014F69))),
                                  Text("Clouds"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.speed),
                                  Text("${data["wind"]["speed"]} m/s",
                                      style: TextStyle(
                                          fontSize: sizes.widthS(18, size),
                                          color: Color(0xff014F69))),
                                  Text("Wind"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text("Data Tidak Ada");
                  }
                } else {
                  return Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: sizes.widthS(100, size),
                      height: sizes.heightS(100, size),
                    ),
                  );
                }
              }),
          FutureBuilder(
            future: controller.getTotCuaca(arg[1]),
            builder: (context, snapsot) {
              if (snapsot.connectionState == ConnectionState.done) {
                if (snapsot.data != null) {
                  var datas = snapsot.data as Map;
                  var lisda = datas["list"] as List;
                  print("${lisda.length}data as");
                  var time = DateTime.parse('${datas["list"][0]["dt_txt"]}');
                  //
                  return Container(
                    width: sizes.widthS(390, size),
                    height: sizes.heightS(480, size),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        sizes.heightS(15, size),
                      ),
                      color: Color(0xffF3F3F1).withOpacity(0.5),
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '${DateFormat.MEd().format(DateTime.parse('${datas["list"][0]["dt_txt"]}'))}',
                                style: TextStyle(
                                    fontSize: sizes.widthS(18, size),
                                    color: Color(0xff014F69))),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][0]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${datas["list"][0]["main"]["temp"]} °c',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][0]["dt_txt"]}'))}'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][1]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][1]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][1]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][3]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][3]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][3]["main"]["temp"]} °c'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '${DateFormat.MEd().format(DateTime.parse('${datas["list"][3]["dt_txt"]}'))}',
                                style: TextStyle(
                                    fontSize: sizes.widthS(18, size),
                                    color: Color(0xff014F69))),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][8]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][8]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][8]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][9]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][9]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][9]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][10]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][10]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][10]["main"]["temp"]} °c'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '${DateFormat.MEd().format(DateTime.parse(
                                  '${datas["list"][11]["dt_txt"]}',
                                ))}',
                                style: TextStyle(
                                    fontSize: sizes.widthS(18, size),
                                    color: Color(0xff014F69))),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][14]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][14]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][14]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][16]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][16]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][16]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][18]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][18]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][18]["main"]["temp"]} °c'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '${DateFormat.MEd().format(DateTime.parse('${datas["list"][19]["dt_txt"]}'))}',
                                style: TextStyle(
                                    fontSize: sizes.widthS(18, size),
                                    color: Color(0xff014F69))),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][20]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][20]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][20]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][22]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][22]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][22]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][24]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][24]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][24]["main"]["temp"]} °c'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '${DateFormat.MEd().format(DateTime.parse('${datas["list"][27]["dt_txt"]}'))}',
                                style: TextStyle(
                                    fontSize: sizes.widthS(18, size),
                                    color: Color(0xff014F69))),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][8]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][8]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][8]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][9]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][9]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][9]["main"]["temp"]} °c'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.network(
                                        "http://openweathermap.org/img/wn/${datas["list"][11]["weather"][0]["icon"]}@2x.png"),
                                    Text(
                                        '${DateFormat.jm().format(DateTime.parse('${datas["list"][11]["dt_txt"]}'))}',
                                        style: TextStyle(
                                            fontSize: sizes.widthS(18, size),
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff014F69))),
                                    Text(
                                        '${datas["list"][11]["main"]["temp"]} °c'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text(
                      'Wilayah yang anda cari tidak ada silakan kembali dan pilih lagi');
                }
              } else {
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: sizes.widthS(100, size),
                    height: sizes.heightS(100, size),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
