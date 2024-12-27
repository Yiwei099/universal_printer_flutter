import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';

part 'DrawCanvas.g.dart';

@JsonSerializable()
class DrawCanvas {
  RxInt maxWidth = 0.obs; // 最大宽度
  RxInt maxHeight = 0.obs; // 最大高度

  RxDouble topIndentation = 40.0.obs; // 顶部距离
  RxDouble startIndentation = 20.0.obs; // 左边距离
  RxDouble endIndentation = 20.0.obs; // 右边距离
  RxDouble bottomBlankHeight = 10.0.obs; // 底部留白
  RxBool antiAlias = false.obs; // 抗锯齿
  RxInt gravity = 0.obs; // 对齐方式
  RxBool followEffectItem = false.obs; // 高度不足终止绘制

  DrawCanvas({
    int maxWidth = 0,
    int maxHeight = 0,
    double topIndentation = 40.0,
    double startIndentation = 20.0,
    double endIndentation = 20.0,
    double bottomBlankHeight = 10.0,
    bool antiAlias = false,
    int gravity = 0,
    bool followEffectItem = false,
  }) {
    this.maxWidth.value = maxWidth;
    this.maxHeight.value = maxHeight;
    this.topIndentation.value = topIndentation;
    this.startIndentation.value = startIndentation;
    this.endIndentation.value = endIndentation;
    this.bottomBlankHeight.value = bottomBlankHeight;
    this.antiAlias.value = antiAlias;
    this.gravity.value = gravity;
    this.followEffectItem.value = followEffectItem;
  }

  factory DrawCanvas.fromJson(Map<String, dynamic> json) =>
      _$DrawCanvasFromJson(json);

  Map<String, dynamic> toJson() => _$DrawCanvasToJson(this);
}
