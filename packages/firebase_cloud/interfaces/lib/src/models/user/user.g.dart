// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return $checkedNew('User', json, () {
    final val = User(
      isAnonymous: $checkedConvert(json, 'is_anonymous', (v) => v as bool),
      id: $checkedConvert(json, 'id', (v) => v as String?),
      dobDay: $checkedConvert(json, 'dob_dd', (v) => v as int?),
      dobMonth: $checkedConvert(json, 'dob_mm', (v) => v as int?),
      dobYear: $checkedConvert(json, 'dob_yyyy', (v) => v as int?),
      email: $checkedConvert(json, 'email', (v) => v as String?),
      displayName: $checkedConvert(json, 'displayName', (v) => v as String?),
      firstName: $checkedConvert(json, 'first_name', (v) => v as String?),
      lastLogin: $checkedConvert(json, 'last_login', (v) => v as int?),
      lastName: $checkedConvert(json, 'last_name', (v) => v as String?),
      phoneNumber: $checkedConvert(json, 'phone_number', (v) => v as String?),
      zipCode: $checkedConvert(json, 'zip_code', (v) => v as String?),
      createdAt: $checkedConvert(json, 'created_at', (v) => v as int?),
    );
    return val;
  }, fieldKeyMap: const {
    'isAnonymous': 'is_anonymous',
    'dobDay': 'dob_dd',
    'dobMonth': 'dob_mm',
    'dobYear': 'dob_yyyy',
    'firstName': 'first_name',
    'lastLogin': 'last_login',
    'lastName': 'last_name',
    'phoneNumber': 'phone_number',
    'zipCode': 'zip_code',
    'createdAt': 'created_at'
  });
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'dob_dd': instance.dobDay,
      'dob_mm': instance.dobMonth,
      'dob_yyyy': instance.dobYear,
      'email': instance.email,
      'displayName': instance.displayName,
      'first_name': instance.firstName,
      'is_anonymous': instance.isAnonymous,
      'last_login': instance.lastLogin,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'zip_code': instance.zipCode,
    };
