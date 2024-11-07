import 'dart:math';

class StringUtils {
  static String getChineseString(int length) {
    final random = Random();
    const int minCodePoint = 0x4e00; // 中文字符的起始 Unicode 编码
    const int maxCodePoint = 0x9fa5; // 中文字符的结束 Unicode 编码

    return List.generate(length, (index) {
      int codePoint = minCodePoint + random.nextInt(maxCodePoint - minCodePoint + 1);
      return String.fromCharCode(codePoint);
    }).join();
  }
}