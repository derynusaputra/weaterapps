import 'package:get/get.dart';
import 'package:weaterdery/app/data/user_provider.dart';

class DashboardController extends GetxController {
  Future getDataCuaca(String kotas) async {
    try {
      var response = await UserProvider().getCurentCuaca(kotas);
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        var body = response.body;

        // print('${body} sisndi');

        return body;
      } else {
        print('gak ada data');
      }
    } catch (e) {}
  }

  Future getTotCuaca(String kota) async {
    try {
      var response = await UserProvider().getTotalCuaca(kota);
      if (response.statusCode == 200) {
        // Iterable it = jsonDecode(response.body);
        var body = response.body;

        print('${body} anyar');

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
  void onClose() {}
  void increment() => count.value++;
}
