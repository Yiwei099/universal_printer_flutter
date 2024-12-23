import 'package:json_annotation/json_annotation.dart';

part 'DrawCanvas.g.dart';

@JsonSerializable()
class DrawCanvas {
  int maxWidth = 0; // 最大宽度
  int maxHeight = 0; // 最大高度

  double topIndentation = 40.0; // 顶部距离
  double startIndentation = 20.0; // 左边距离
  double endIndentation = 20.0; // 右边距离
  double bottomBlankHeight = 10.0; // 底部留白
  bool antiAlias = false; // 抗锯齿
  int gravity = 0; // 对齐方式
  bool followEffectItem = true; //高度不足终止绘制

  DrawCanvas({
    this.maxWidth = 0,
    this.maxHeight = 0,
    this.topIndentation = 40.0,
    this.startIndentation = 20.0,
    this.endIndentation = 20.0,
    this.bottomBlankHeight = 10.0,
    this.antiAlias = false,
    this.gravity = 0,
    this.followEffectItem = false,
  });

  factory DrawCanvas.fromJson(Map<String, dynamic> json) =>
      _$DrawCanvasFromJson(json);

  Map<String, dynamic> toJson() => _$DrawCanvasToJson(this);
}
