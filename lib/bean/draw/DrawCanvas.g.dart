// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DrawCanvas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrawCanvas _$DrawCanvasFromJson(Map<String, dynamic> json) => DrawCanvas(
      maxWidth: (json['maxWidth'] as num?)?.toInt() ?? 0,
      maxHeight: (json['maxHeight'] as num?)?.toInt() ?? 0,
      topIndentation: (json['topIndentation'] as num?)?.toDouble() ?? 40.0,
      startIndentation: (json['startIndentation'] as num?)?.toDouble() ?? 20.0,
      endIndentation: (json['endIndentation'] as num?)?.toDouble() ?? 20.0,
      bottomBlankHeight:
          (json['bottomBlankHeight'] as num?)?.toDouble() ?? 10.0,
      antiAlias: json['antiAlias'] as bool? ?? false,
      gravity: (json['gravity'] as num?)?.toInt() ?? 0,
      followEffectItem: json['followEffectItem'] as bool? ?? false,
    );

Map<String, dynamic> _$DrawCanvasToJson(DrawCanvas instance) =>
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
    };
