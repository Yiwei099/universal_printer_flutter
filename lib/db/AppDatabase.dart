import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:universal_printer_flutter/db/dao/DrawElementDao.dart';

import '../bean/draw/element/TextElement.dart';

part 'AppDatabase.g.dart';


@Database(version: 1, entities: [TextElement])
abstract class AppDatabase extends FloorDatabase {
  DrawElementDao get drawElementDao;
}