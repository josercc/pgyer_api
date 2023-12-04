import 'package:dio/dio.dart';
import 'package:pgyer_api/pgyer_api.dart';

class BuildInfo extends PgyerApi<BuildInfoResponse> {
  final String apiKey;
  final String buildKey;

  BuildInfo({required this.apiKey, required this.buildKey});

  @override
  BuildInfoResponse conver(Map json) {
    return BuildInfoResponse.fromJson(json);
  }

  @override
  Future<Map<String, dynamic>> get data async => {
        '_api_key': apiKey,
        'buildKey': buildKey,
      };

  @override
  String get path => '/app/buildInfo';

  UploadState getUploadState(Response response) =>
      UploadState.values.firstWhere((e) => e.code == getCode(response));
}

class BuildInfoResponse {
  final String buildKey;
  final int buildType;
  final int buildIsFirst;
  final int buildIsLastest;
  final int buildFileSize;
  final String buildName;
  final String buildVersion;
  final String buildVersionNo;
  final int buildBuildVersion;
  final String buildIdentifier;
  final String buildIcon;
  final String buildDescription;
  final String buildUpdateDescription;
  final String buildScreenShots;
  final String buildShortcutUrl;
  final String buildQRCodeURL;
  final String buildCreated;
  final String buildUpdated;

  BuildInfoResponse({
    required this.buildKey,
    required this.buildType,
    required this.buildIsFirst,
    required this.buildIsLastest,
    required this.buildFileSize,
    required this.buildName,
    required this.buildVersion,
    required this.buildVersionNo,
    required this.buildBuildVersion,
    required this.buildIdentifier,
    required this.buildIcon,
    required this.buildDescription,
    required this.buildUpdateDescription,
    required this.buildScreenShots,
    required this.buildShortcutUrl,
    required this.buildQRCodeURL,
    required this.buildCreated,
    required this.buildUpdated,
  });

  factory BuildInfoResponse.fromJson(Map map) {
    return BuildInfoResponse(
      buildKey: map['buildKey'],
      buildType: map['buildType'],
      buildIsFirst: map['buildIsFirst'],
      buildIsLastest: map['buildIsLastest'],
      buildFileSize: map['buildFileSize'],
      buildName: map['buildName'],
      buildVersion: map['buildVersion'],
      buildVersionNo: map['buildVersionNo'],
      buildBuildVersion: map['buildBuildVersion'],
      buildIdentifier: map['buildIdentifier'],
      buildIcon: map['buildIcon'],
      buildDescription: map['buildDescription'],
      buildUpdateDescription: map['buildUpdateDescription'],
      buildScreenShots: map['buildScreenShots'],
      buildShortcutUrl: map['buildShortcutUrl'],
      buildQRCodeURL: map['buildQRCodeURL'],
      buildCreated: map['buildCreated'],
      buildUpdated: map['buildUpdated'],
    );
  }
}

enum UploadState {
  success(0),
  failure(1216),
  uploading(1247),
  waiting(1246);

  final int code;
  const UploadState(this.code);
}
