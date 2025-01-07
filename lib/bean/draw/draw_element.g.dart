// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrawElement _$DrawElementFromJson(Map<String, dynamic> json) => DrawElement(
      id: (json['id'] as num?)?.toInt(),
      elementType: (json['elementType'] as num).toInt(),
      perLineSpac: (json['perLineSpac'] as num?)?.toInt() ?? 10,
      text: json['text'] as String? ?? '',
      alignment: (json['alignment'] as num?)?.toInt() ?? 0,
      fontSize: (json['fontSize'] as num?)?.toInt() ?? 16,
      autoEnter: json['autoEnter'] as bool? ?? true,
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
      typeFace: (json['typeFace'] as num?)?.toInt() ?? 0,
      sortNum: (json['sortNum'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DrawElementToJson(DrawElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortNum': instance.sortNum,
      'elementType': instance.elementType,
      'perLineSpac': instance.perLineSpac,
      'text': instance.text,
      'alignment': instance.alignment,
      'fontSize': instance.fontSize,
      'autoEnter': instance.autoEnter,
      'weight': instance.weight,
      'typeFace': instance.typeFace,
    };
