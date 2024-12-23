
import 'package:json_annotation/json_annotation.dart';

part 'TextElement.g.dart';

@JsonSerializable()
class TextElement {
  final String text;
  late int alignment;
  late int fontSize;
  late int perLineSpac;
  late bool autoEnter;


  TextElement({required this.text, this.alignment = 0, this.fontSize = 16,this.autoEnter = true,this.perLineSpac = 10});

  factory TextElement.fromJson(Map<String, dynamic> json) => _$TextElementFromJson(json);
  Map<String, dynamic> toJson() => _$TextElementToJson(this);
}
