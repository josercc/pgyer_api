import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pgyer_api/pgyer_api.dart';

class UploadFile extends PgyerApi {
  final String endpoint;
  final String key;
  final String signature;
  final String xCosSecurityToken;
  final String? xCosMetaFileName;
  final String file;

  UploadFile({
    required this.endpoint,
    required this.key,
    required this.signature,
    required this.xCosSecurityToken,
    required this.file,
    this.xCosMetaFileName,
  });

  @override
  conver(Map json) {
    throw UnimplementedError();
  }

  @override
  Future<FormData> get data async => FormData.fromMap({
        'key': key,
        'signature': signature,
        'x-cos-security-token': xCosSecurityToken,
        'x-cos-meta-file-name': xCosMetaFileName,
        'file': MultipartFile.fromBytes(await File(file).readAsBytes()),
      });

  @override
  String get path => '';

  @override
  String? get url => endpoint;

  @override
  bool isSuccess(Response response) => response.statusCode == 204;

  @override
  String get contentType => 'multipart/form-data';
}
