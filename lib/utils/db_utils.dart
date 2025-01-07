import 'package:floor/floor.dart';
import 'package:universal_printer_flutter/db/dao/dao_bitmap_option.dart';
import 'package:universal_printer_flutter/db/dao/draw_element_dao.dart';

import '../bean/draw/bitmap_option.dart';
import '../db/app_data_base.dart';

class DBUtil {
  //<editor-fold desc="单例的实现">
  static final DBUtil _instance = DBUtil._internal(); //唯一单例, _代表类私有,禁止外部直接访问
  factory DBUtil() => _getInstance(); //使用工厂构造方法，通过Test()获取类时，返回唯一实例
  static DBUtil get instance => _getInstance(); //通过静态变量instance获取实例

  static DBUtil _getInstance(){
    //这里真正生成唯一实例
    return _instance;
  }

  DBUtil._internal(){
    //命名构造函数
    //初始化
    // print('Channel 初始化啦');
  }
  //</editor-fold desc="单例的实现">

  //定义数据库变量
  late final AppDatabase _db;

  DaoBitmapOption get daoBitmapOption => _db.daoBitmapOption;

  initDB() async {
    _db = await $FloorAppDatabase.databaseBuilder('AppDatabase.db').build();
  }

  Future<BitmapOption?> getBitmapOptionByType(int type) {
    return daoBitmapOption.queryBitmapOptionByType(type);
  }

  Future<List<BitmapOption>> getBitmapOptions() {
    return daoBitmapOption.queryBitmapOption();
  }

  Future<void> saveOptionItem(BitmapOption b) {
    return daoBitmapOption.insertBitmapOption(b);
  }

  Future<void> updateOptionItem(BitmapOption b) {
    return daoBitmapOption.updateBitmapOption(b);
  }
}
