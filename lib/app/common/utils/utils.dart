

class Utils {
  ///格式化播放时间
  static formatSeconds(double millisecond) {
    int second0 = millisecond ~/ 1000;
    if (second0 <= 0) {
      return "00:00";
    } else if (second0 < 60) {
      String second = (second0 % 60).toInt().toString().padLeft(2, '0');
      return "00:$second";
    } else if (second0 < 3600) {
      String second = (second0 % 60).toString().padLeft(2, '0');
      String minute = (second0 ~/ 60).toString().padLeft(2, '0');
      return "$minute:$second";
    } else {
      String second = (second0 % 60).toString().padLeft(2, '0');
      String minute = (second0 % 3600 ~/ 60).toString().padLeft(2, '0');
      String hour = (second0 ~/ 3600).toString().padLeft(2, '0');
      return "$hour:$minute:$second";
    }
  }

  ///格式化大于等于1万的数字为x.x万，如果小于等于0时则显示占位符
  static String formatThousand(num, {placeholder = "赞"}) {
    if (num <= 0) {
      return placeholder;
    } else if (num < 10000) {
      return num.toString();
    } else {
      return "${(num / 10000.0).toStringAsFixed(1)}万";
    }
  }

  /// md5 加密


  /// 解析URL参数
  static Map parseQuery(String url) {
    var parame = {};
    if (url.isNotEmpty && url.contains("?")) {
      url.split("?")[1].split("&").forEach((str) {
        var pair = str.split("=");
        String key = pair[0],
            value = pair[1];
        if (key.isNotEmpty && value.isNotEmpty) {
          parame[key] = value;
        }
      });
    }
    return parame;
  }

  static String parsePageName(String url) {
    String pageName = "";
    if (url.isNotEmpty) {
      if (url.contains("?")) {
        pageName = url.split("?")[0];
      } else {
        pageName = url;
      }
    }
    return pageName;
  }
}