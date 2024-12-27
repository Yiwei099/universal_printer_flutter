import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TextElement.g.dart';

@entity
@JsonSerializable()
class TextElement {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String text;
  late int alignment;
  late int fontSize;
  late int perLineSpac;
  late bool autoEnter;

  TextElement(
      {this.id,
      required this.text,
      this.alignment = 0,
      this.fontSize = 16,
      this.autoEnter = true,
      this.perLineSpac = 10});

  factory TextElement.fromJson(Map<String, dynamic> json) =>
      _$TextElementFromJson(json);

  Map<String, dynamic> toJson() => _$TextElementToJson(this);
}
