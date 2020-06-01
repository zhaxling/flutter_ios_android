import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bot_toast/bot_toast.dart';

// ignore: must_be_immutable
class MethodListPage extends StatelessWidget {
  MethodListPage({Key key, this.title}) : super(key: key);

  final String title;

  var methods = ["调用原生方法+参数", "跳转原生新页面", "获取原生数据"];

  static MethodChannel channel = MethodChannel("com.flutter.channel.ios");

  void tapAction(int index) {
    if (index == 0) {
      channel.invokeMethod("pop", "1234");
    }
    if (index == 1) {
      Map map = Map();
      map["uri"] = "pay";
      channel.invokeMethod("push", map);
    }
    if (index == 2) {
      getArgument();
    }
  }

  Future<void> getArgument() async {
    final result = await channel.invokeMethod("payResult", "id123456");

    BotToast.showText(text: result["a"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 56,
              child: GestureDetector(
                child: Center(
                  child: Text("${methods[index]}",style: TextStyle(
                    fontSize: 18
                  ),),
                ),
                onTap: () {
                  tapAction(index);
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1.0,
              color: Colors.red,
            );
          },
          itemCount: methods.length,
          cacheExtent: 56,
        )
    );
  }
}
