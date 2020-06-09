

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ios_android_module/accounts/account.dart';
import 'package:flutter_ios_android_module/inputpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

import 'global/zxl_utils.dart';

class AppointPage extends StatelessWidget {

  static const MethodChannel methodChannel = MethodChannel('com.pages/native_ios');

  @override
  Widget build(BuildContext context) {

    printScreenInformation(context);
    // 创建一个给native的channel (类似iOS的通知）

    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              child: _buttons(context)
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          methodChannel.invokeMethod('flutterPop');
        },
        child: Text('退出'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
  /* 创建底部按钮 */
  Widget _buttons(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setHeight(200),
      child: Row(
        children: <Widget>[
          _createButton("记账", context, (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return InputPage();
            }));
          }),
          _createButton("记账记录", context, (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AccountPage();
            }));
          }),
        ],
      ),
    );
  }

  /* 创建按钮 */
  Widget _createButton(String title, BuildContext context, Function tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.only(left: ScreenUtil().setHeight(350 * 0.25)),
        width: ScreenUtil().setHeight(200),
        height: ScreenUtil().setHeight(200),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(200)))
        ),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}
