
import 'package:floor/floor.dart';
import 'package:universal_printer_flutter/bean/draw/element/text_element.dart';

import '../../bean/draw/draw_element.dart';

@dao
abstract class DrawElementDao {

  @Query('Select * from DrawElement order by sortNum desc')
  Future<List<DrawElement>> queryAllElement();

  @Insert()
  Future<void> insertElement(DrawElement element);

  @delete
  Future<void> deleteElement(DrawElement element);

  @update
  Future<void> updateElement(DrawElement element);
}