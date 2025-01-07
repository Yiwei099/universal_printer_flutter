import 'package:floor/floor.dart';
import 'package:universal_printer_flutter/bean/draw/bitmap_option.dart';

@dao
abstract class DaoBitmapOption {

  @Query('Select * from BitmapOption')
  Future<List<BitmapOption>> queryBitmapOption();

  @Query('Select * from BitmapOption where bitmapType = :type')
  Future<BitmapOption?> queryBitmapOptionByType(int type);

  @update
  Future<void> updateBitmapOption(BitmapOption bitmapOption);

  @insert
  Future<void> insertBitmapOption(BitmapOption bitmapOption);
}