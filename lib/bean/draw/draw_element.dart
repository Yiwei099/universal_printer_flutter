import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'draw_element.g.dart';

@entity
@JsonSerializable()
class DrawElement {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? sortNum;

  /// 公共属性
  int elementType; //元素类型：0 = 文本；1 = 图像；2 = 实线；3 = 虚线；
  int perLineSpac; //每行间距

  /// 文本类型特有属性
  String text; //文本内容，文本元素必填
  int alignment; //对齐方式
  int fontSize; //字体大小
  bool autoEnter; //是否自动换行
  double weight; //宽度占比
  int typeFace; //字体样式：0 = 正常；1 = 斜体；2 = 粗体

  DrawElement({
    this.id,
    required this.elementType,
    this.perLineSpac = 10,
    this.text = '',
    this.alignment = 0,
    this.fontSize = 16,
    this.autoEnter = true,
    this.weight = 1.0,
    this.typeFace = 0,
    this.sortNum = 0,
  });
}
