// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) {
  return AppConfig(
    androidUpgradeUrl: json['androidUpgradeUrl'] as String,
    downForMaintenance: json['downForMaintenance'] as bool,
    iosUpgradeUrl: json['iosUpgradeUrl'] as String,
    minAndroidBuildNumber: json['minAndroidBuildNumber'] as int,
    minIosBuildNumber: json['minIosBuildNumber'] as int,
  );
}

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'androidUpgradeUrl': instance.androidUpgradeUrl,
      'downForMaintenance': instance.downForMaintenance,
      'iosUpgradeUrl': instance.iosUpgradeUrl,
      'minAndroidBuildNumber': instance.minAndroidBuildNumber,
      'minIosBuildNumber': instance.minIosBuildNumber,
    };
