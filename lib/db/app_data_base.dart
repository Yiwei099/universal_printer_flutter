import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:universal_printer_flutter/db/dao/dao_bitmap_option.dart';
import 'package:universal_printer_flutter/db/dao/draw_element_dao.dart';

import '../bean/draw/bitmap_option.dart';
import '../bean/draw/draw_element.dart';
import '../bean/draw/element/text_element.dart';

part 'app_data_base.g.dart';


@Database(version: 1, entities: [BitmapOption,DrawElement])
abstract class AppDatabase extends FloorDatabase {
  DaoBitmapOption get daoBitmapOption;
  DrawElementDao get drawElementDao;
}