import 'package:pgyer_api/src/pgyer_api.dart';

class GetCosToken extends PgyerApi<GetCosTokenResponse> {
  final String apiKey;
  // 需要上传的应用类型，如果是iOS类型请传ios或ipa，如果是Android类型请传android或apk
  final String buildType;
  // 是否使用海外加速上传，值为：1 使用海外加速上传，2 国内加速上传；留空根据 IP 自动判断海外加速或国内加速
  final int? oversea;
  // 应用安装方式，值为(1,2,3，默认为1 公开安装)。1：公开安装，2：密码安装，3：邀请安装
  final int? buildInstallType;
  // 设置App安装密码，密码为空时默认公开安装
  final String? buildPassword;
  // 应用介绍，如没有介绍请传空字符串，或不传。
  final String? buildDescription;
  // 版本更新描述，请传空字符串，或不传。
  final String? buildUpdateDescription;
  // 是否设置安装有效期，值为：1 设置有效时间， 2 长期有效，如果不填写不修改上一次的设置
  final String? buildInstallDate;
  // 安装有效期开始时间，字符串型，如：2018-01-01
  final String? buildInstallStartDate;
  // 安装有效期结束时间，字符串型，如：2018-12-31
  final String? buildInstallEndDate;
  // 所需更新指定的渠道短链接，渠道短链接须为已创建成功的，并且只可指定一个渠道，字符串型，如：abcd
  final String? buildChannelShortcut;

  GetCosToken({
    required this.apiKey,
    required this.buildType,
    this.oversea,
    this.buildInstallType,
    this.buildPassword,
    this.buildDescription,
    this.buildUpdateDescription,
    this.buildInstallDate,
    this.buildInstallStartDate,
    this.buildInstallEndDate,
    this.buildChannelShortcut,
  });

  @override
  Future<Map<String, dynamic>> get data async => {
        '_api_key': apiKey,
        'buildType': buildType,
        'oversea': oversea,
        'buildInstallType': buildInstallType,
        'buildPassword': buildPassword,
        'buildDescription': buildDescription,
        'buildUpdateDescription': buildUpdateDescription,
        'buildInstallDate': buildInstallDate,
        'buildInstallStartDate': buildInstallStartDate,
        'buildInstallEndDate': buildInstallEndDate,
        'buildChannelShortcut': buildChannelShortcut,
      };

  @override
  String get path => '/app/getCOSToken';

  @override
  GetCosTokenResponse conver(Map json) {
    return GetCosTokenResponse.fromJson(json);
  }
}

class GetCosTokenResponse {
  final String key;
  final String endpoint;
  final Map params;

  GetCosTokenResponse({
    required this.key,
    required this.endpoint,
    required this.params,
  });

  factory GetCosTokenResponse.fromJson(Map json) {
    return GetCosTokenResponse(
      key: json['key'],
      endpoint: json['endpoint'],
      params: json['params'],
    );
  }
}
