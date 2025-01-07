import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bitmap_option.g.dart';

@entity
@JsonSerializable()
class BitmapOption {

  int maxWidth;
  int maxHeight;
  double topIndentation;
  double startIndentation;
  double endIndentation;
  double bottomBlankHeight;
  bool antiAlias;
  int gravity;
  bool followEffectItem;
  @primaryKey
  int bitmapType; //0 = 小票；1 = 标签

  BitmapOption({
    this.maxWidth = 0,
    this.maxHeight = 0,
    this.topIndentation = 40.0,
    this.startIndentation = 20.0,
    this.endIndentation = 20.0,
    this.bottomBlankHeight = 10.0,
    this.antiAlias = true,
    this.gravity = 0,
    this.followEffectItem = false,
    this.bitmapType = 0,
  });

}