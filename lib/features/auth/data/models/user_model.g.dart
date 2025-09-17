// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      phone: json['phone'] as String?,
      roles:
          (json['roles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'phone': instance.phone,
      'roles': instance.roles,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'verified': instance.verified,
    };
