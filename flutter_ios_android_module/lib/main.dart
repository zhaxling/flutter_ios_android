import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_ios_android_module/method.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter 测试",
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: MethodListPage(title: "标题",),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _textString = "00";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 创建一个给native的channel (类似iOS的通知）
  static const MethodChannel methodChannel = MethodChannel('com.pages.your/native_get');

  _iOSPushToVC() async {
    await methodChannel.invokeMethod('FlutterPopIOS', '参数');
  }

  void _backAction() {
    _iOSPushToVC();
  }

  void _pushIOSNewVC() async {
    Map<String, dynamic> map = {"code": "200", "data":[1,2,3]};

    await methodChannel.invokeMethod('FlutterCickedActionPushIOSNewVC', map);
  }

  Future<void> _FlutterGetIOSArguments(para) async {
    BotToast.showText(text:"_FlutterGetIOSArguments");
    try {
      final result = await methodChannel.invokeMethod('FlutterGetIOSArguments', para);


      BotToast.showText(text:result["a"]);
      _textString = result["a"];

      // 刷新界面
      setState(() {});
    } on PlatformException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times1:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FloatingActionButton(
              onPressed: _backAction,
              child: Icon(Icons.accessibility),
            ),
            FloatingActionButton(
              onPressed: _pushIOSNewVC,
              child: Icon(Icons.accessibility),
            ),
            FloatingActionButton(
              onPressed:() {
                _FlutterGetIOSArguments("flutter传值");
              },
              child: Icon(Icons.accessibility),
            ),
            Text(_textString),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

