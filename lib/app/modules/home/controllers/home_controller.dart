import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weaterdery/app/data/user_provider.dart';

class HomeController extends GetxController {
  final nameC = TextEditingController();
  var kota = ''.obs;
  var provinsi = ''.obs;

  Future getDataProvinsi() async {
    try {
      var response = await UserProvider().getProvinsi();
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        var body = response.body['provinsi'];

        // print('${body['provinsi'][11]["nama"]}');

        return body;
      } else {
        print('gak ada data');
      }
    } catch (e) {}
  }

  Future getDataKota(String idkota) async {
    try {
      var response = await UserProvider().getKota(idkota);
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        var body = (response.body['kota_kabupaten']) as List;

        // print('${body['provinsi'][11]["nama"]}');

        return body;
      } else {
        print('gak ada data');
      }
    } catch (e) {}
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    kota.value;
  }

  void increment() => count.value++;
}
