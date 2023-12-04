import 'dart:convert';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:dio/dio.dart';
export './get_cos_token.dart';
export './build_info.dart';
export './upload_file.dart';

class PgyerApiV2 {
  final baseUrl = 'https://www.pgyer.com/apiv2';

  Future<Response> request(PgyerApi api) async {
    final dio = Dio(BaseOptions(
      headers: {'Content-Type': api.contentType},
      sendTimeout: Duration(hours: 1),
    ));

    final url = api.url ?? '$baseUrl${api.path}';

    final data = await api.data;

    print('[send data:$url]: $data');
    final response = await dio.post(url, data: data);
    print('[response data:$url]: ${json.encode(response.data)}');
    return response;
  }
}

abstract class PgyerApi<R> {
  String get path;
  Future<dynamic> get data;
  R conver(Map json);
  String? get url => null;

  int getCode(Response response) => JSON(response.data)['code'].intValue;

  bool isSuccess(Response response) => getCode(response) == 0;

  R? getResponse(Response response) {
    if (!isSuccess(response)) return null;
    return conver(JSON(response.data)['data'].rawValue);
  }

  String get contentType => 'application/x-www-form-urlencoded';
}
