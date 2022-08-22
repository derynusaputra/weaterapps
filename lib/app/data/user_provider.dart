import 'package:get/get.dart';

class UserProvider extends GetConnect {
  final urlProvinsi = 'https://dev.farizdotid.com/api/daerahindonesia/provinsi';
  final urlKota =
      'https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=';
  final Cuaca =
      'https://api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}';
  final curentCuaca =
      'https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}';

  Future<Response> getProvinsi() {
    return get(
      urlProvinsi,
    );
  }

  Future<Response> getKota(String id) {
    return get(
      urlKota + "$id",
    );
  }

  Future<Response> getCurentCuaca(String kota) {
    return get(curentCuaca, query: {
      "q": "$kota",
      "appid": "38d5575a184289cc1e4e07ba6c79771b",
      "units": "metric"
    });
  }

  Future<Response> getTotalCuaca(String kota) {
    return get(Cuaca, query: {
      "q": "$kota",
      "appid": "38d5575a184289cc1e4e07ba6c79771b",
      "units": "metric"
    });
  }
}
