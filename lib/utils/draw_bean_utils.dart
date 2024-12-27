import '../bean/item.dart';
import '../constant/constant.dart';

class DrawBeanUtils {

  static List<Item<DrawType>> getDrawTypeList() {
    return [
      Item<DrawType>(key: DrawType.text, name: '文本'),
      Item<DrawType>(key: DrawType.image, name: '图片'),
      Item<DrawType>(key: DrawType.line, name: '分割线'),
      Item<DrawType>(key: DrawType.dashLine, name: '虚线'),
    ];
  }
}