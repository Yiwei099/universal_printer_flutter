// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TextElement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextElement _$TextElementFromJson(Map<String, dynamic> json) => TextElement(
      text: json['text'] as String,
      alignment: (json['alignment'] as num?)?.toInt() ?? 0,
      fontSize: (json['fontSize'] as num?)?.toInt() ?? 16,
      autoEnter: json['autoEnter'] as bool? ?? true,
      perLineSpac: (json['perLineSpac'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$TextElementToJson(TextElement instance) =>
    <String, dynamic>{
      'text': instance.text,
      'alignment': instance.alignment,
      'fontSize': instance.fontSize,
      'perLineSpac': instance.perLineSpac,
      'autoEnter': instance.autoEnter,
    };
