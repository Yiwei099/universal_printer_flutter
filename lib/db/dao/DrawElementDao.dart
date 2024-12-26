
import 'package:floor/floor.dart';
import 'package:universal_printer_flutter/bean/draw/element/TextElement.dart';

@dao
abstract class DrawElementDao {

  @Query('Select * from TextElement')
  Future<List<TextElement>> queryAllElement();

  @Insert()
  Future<void> insertElement(TextElement element);

  @delete
  Future<void> deleteElement(TextElement element);

  @update
  Future<void> updateElement(TextElement element);
}