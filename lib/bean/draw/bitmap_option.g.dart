// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitmap_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitmapOption _$BitmapOptionFromJson(Map<String, dynamic> json) => BitmapOption(
      maxWidth: (json['maxWidth'] as num?)?.toInt() ?? 0,
      maxHeight: (json['maxHeight'] as num?)?.toInt() ?? 0,
      topIndentation: (json['topIndentation'] as num?)?.toDouble() ?? 40.0,
      startIndentation: (json['startIndentation'] as num?)?.toDouble() ?? 20.0,
      endIndentation: (json['endIndentation'] as num?)?.toDouble() ?? 20.0,
      bottomBlankHeight:
          (json['bottomBlankHeight'] as num?)?.toDouble() ?? 10.0,
      antiAlias: json['antiAlias'] as bool? ?? true,
      gravity: (json['gravity'] as num?)?.toInt() ?? 0,
      followEffectItem: json['followEffectItem'] as bool? ?? false,
      bitmapType: (json['bitmapType'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BitmapOptionToJson(BitmapOption instance) =>
    <String, dynamic>{
      'maxWidth': instance.maxWidth,
      'maxHeight': instance.maxHeight,
      'topIndentation': instance.topIndentation,
      'startIndentation': instance.startIndentation,
      'endIndentation': instance.endIndentation,
      'bottomBlankHeight': instance.bottomBlankHeight,
      'antiAlias': instance.antiAlias,
      'gravity': instance.gravity,
      'followEffectItem': instance.followEffectItem,
      'bitmapType': instance.bitmapType,
    };
