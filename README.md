# pgyer_api

用于通过接口的方式上传应用到蒲公英

## 安装

```shell
dart pub add pgyer_api
```

## 使用

上传应用一共分了三个步骤

1. 获取上传应用的信息

   ```dart
   final response = await PgyerApiV2().request(GetCosToken(
     apiKey: apiKey,
     buildType: 'ios'// ios|android,
   ))
   ```

2. 上传应用

   ```dart
   final response = await PgyerApiV2().request(UploadFile(
     endpoint: response.endpoint,
     key: response.key,
     signature: response.params['signature'],
     xCosSecurityToken: response.params['x-cos-security-token'],
     file: ipa, // 这里是上传应用的文件路径
   ))
   ```

3. 检测应用是否上传成功

   ```dart
   final response = await PgyerApiV2().request(BuildInfo(apiKey: apiKey, 
   buildKey: getCosTokenResponse.key,))
   ```

具体的参数信息请参考代码注释或者蒲公英官方的文档 https://www.pgyer.com/doc/view/api

