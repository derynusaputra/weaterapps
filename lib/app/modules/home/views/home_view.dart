import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weaterdery/app/data/sizing.dart';
import 'package:weaterdery/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:weaterdery/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var contr = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizes = Sizing();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff014F69),
        title: Text('HOME'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: controller.getDataProvinsi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var snap = snapshot.data;
              // print('${snap}ini snpanyssa');
              var list = <DropdownMenuItem<String>>[];
              for (var i = 0; i < snap.length; i++) {
                list.add(
                  DropdownMenuItem<String>(
                    child: Text(
                        // ${(listAlllokasi[i].data() as Map<String, dynamic>)["nama"]}
                        '${snap[i]["nama"]}'),
                    value: '${snap[i]["id"]}',
                  ),
                );
              }
              // print('${listAlllokasi}');
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value == "") {
                          return "Nama Harus DiIsi";
                        } else {
                          return null;
                        }
                      },
                      // controller: _userController,
                      controller: controller.nameC,
                      decoration: InputDecoration(label: Text('Name')),
                    ),
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Pilih Provinsi";
                        } else {
                          return null;
                        }
                      },
                      // value: 'dery',
                      hint: Text(
                        "Pilih Provinsi",
                      ),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.greenAccent))),
                      isExpanded: true,
                      items: list,
                      iconSize: 5,
                      onChanged: (value) {
                        controller.provinsi.value = value!;
                      },
                    ),
                    Obx(() {
                      return controller.provinsi.value != ''
                          ? FutureBuilder(
                              future: controller
                                  .getDataKota(controller.provinsi.value),
                              builder: (context, snapsh) {
                                if (snapsh.connectionState ==
                                    ConnectionState.done) {
                                  // final dery = [snapsh.data];
                                  final dataList = <DropdownMenuItem<String>>[];
                                  var snapp = snapsh.data;
                                  var listsa = snapp as List;
                                  for (var i = 0; i < snapp.length; i++) {
                                    dataList.add(
                                      DropdownMenuItem<String>(
                                        child: Text(
                                            // ${(listAlllokasi[i].data() as Map<String, dynamic>)["nama"]}
                                            '${listsa[i]["nama"]}'),
                                        value: '${listsa[i]["nama"]}',
                                      ),
                                    );
                                  }
                                  return DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Kota Harus diIsi";
                                      } else {
                                        return null;
                                      }
                                    },
                                    // value: 'dery',
                                    hint: Text(
                                      "Pilih Kota Anda",
                                    ),
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.greenAccent))),
                                    isExpanded: true,
                                    items: dataList,
                                    iconSize: 5,
                                    onChanged: (value) {
                                      controller.kota.value = value!;
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            )
                          : SizedBox();
                    }),
                    SizedBox(
                      width: sizes.widthS(380, size),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff014F69),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (controller.nameC.text == '' ||
                                  controller.kota == '') {
                                print('Kosoong');
                              } else {
                                print('ada ya');

                                Get.toNamed(Routes.DASHBOARD, arguments: [
                                  controller.nameC.text,
                                  controller.kota.value
                                ]);
                              }
                            }
                          },
                          child: Text('Submit')),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
