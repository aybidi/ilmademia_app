// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionResult _$ActionResultFromJson(Map<String, dynamic> json) {
  return $checkedNew('ActionResult', json, () {
    final val = ActionResult(
      success: $checkedConvert(json, 'success', (v) => v as bool?),
      msg: $checkedConvert(json, 'msg', (v) => v as String?),
      data: $checkedConvert(json, 'data', (v) => v),
    );
    return val;
  });
}

Map<String, dynamic> _$ActionResultToJson(ActionResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };
