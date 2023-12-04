import 'dart:io';

import 'package:path/path.dart';
import 'package:pgyer_api/pgyer_api.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() async {
  String pwd = Platform.environment['PWD']!;
  late String apiKey;
  late String ipa;
  late String apk;

  setUp(() async {
    print('setUp');
    pwd = Platform.environment['PWD']!;
    pwd = '/Users/king/Downloads/pgyer_api';
    final yamlContent = await File(join(pwd, 'pgyer.yaml')).readAsString();
    final yaml = loadYaml(yamlContent);
    apiKey = yaml['api_key'];
    ipa = yaml['ipa'];
    apk = yaml['apk'];
  });

  test(
    '测试上传ipa',
    () async {
      print('获取上传凭证......');
      final getCosTokenApi = GetCosToken(
        apiKey: apiKey,
        buildType: 'ios',
      );
      final result = await PgyerApiV2().request(getCosTokenApi);
      GetCosTokenResponse? getCosTokenResponse =
          getCosTokenApi.getResponse(result);
      expect(getCosTokenResponse != null, true);

      print('上传文件......');
      final uploadFileApi = UploadFile(
        endpoint: getCosTokenResponse!.endpoint,
        key: getCosTokenResponse.key,
        signature: getCosTokenResponse.params['signature'],
        xCosSecurityToken: getCosTokenResponse.params['x-cos-security-token'],
        file: ipa,
      );
      final resule = await PgyerApiV2().request(uploadFileApi);
      expect(uploadFileApi.isSuccess(resule), true);

      /// 测试上传结果
      UploadState? uploadState;
      while (true) {
        final buildInfoApi =
            BuildInfo(apiKey: apiKey, buildKey: getCosTokenResponse.key);
        final result = await PgyerApiV2().request(buildInfoApi);
        final state = buildInfoApi.getUploadState(result);
        if (state == UploadState.uploading || state == UploadState.waiting) {
          await Future.delayed(Duration(seconds: 5));
          continue;
        }
        uploadState = state;
        break;
      }
      expect(uploadState == UploadState.success, true);
    },
    timeout: Timeout.none,
  );

  test(
    '测试上传apk',
    () async {
      print('获取上传凭证......');
      final getCosTokenApi = GetCosToken(
        apiKey: apiKey,
        buildType: 'android',
      );
      final result = await PgyerApiV2().request(getCosTokenApi);
      GetCosTokenResponse? getCosTokenResponse =
          getCosTokenApi.getResponse(result);
      expect(getCosTokenResponse != null, true);

      print('上传文件......');
      final uploadFileApi = UploadFile(
        endpoint: getCosTokenResponse!.endpoint,
        key: getCosTokenResponse.key,
        signature: getCosTokenResponse.params['signature'],
        xCosSecurityToken: getCosTokenResponse.params['x-cos-security-token'],
        file: apk,
      );
      final resule = await PgyerApiV2().request(uploadFileApi);
      expect(uploadFileApi.isSuccess(resule), true);

      /// 测试上传结果
      UploadState? uploadState;
      while (true) {
        final buildInfoApi =
            BuildInfo(apiKey: apiKey, buildKey: getCosTokenResponse.key);
        final result = await PgyerApiV2().request(buildInfoApi);
        final state = buildInfoApi.getUploadState(result);
        if (state == UploadState.uploading || state == UploadState.waiting) {
          await Future.delayed(Duration(seconds: 5));
          continue;
        }
        uploadState = state;
        break;
      }
      expect(uploadState == UploadState.success, true);
    },
    timeout: Timeout.none,
  );
}
