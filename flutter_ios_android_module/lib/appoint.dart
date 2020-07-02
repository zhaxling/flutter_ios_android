

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ios_android_module/accounts/account.dart';
import 'package:flutter_ios_android_module/inputpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'global/HuiZongAlertDialog.dart';

import 'global/jhPickerTool.dart';
import 'global/zxl_utils.dart';

// ignore: must_be_immutable
class AppointPage extends StatelessWidget {

  static const MethodChannel methodChannel = MethodChannel('com.pages/native_ios');

  // 记录
  List records;

  // 付款人
  var payList = ["所有人","王球", "李三凤", "郑阳洁", "不吃牛的草"];
  var currentPayIndex = 0;// 表示所有人

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
            _createRecordsList(context),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              child: _buttons(context)
            ),
            Positioned(
              top: 10,
              right: 10,
              child: _createSortButton(context),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          methodChannel.invokeMethod('flutterPop');
        },
        child: Text('退出'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
  /* 创建底部按钮 */
  Widget _buttons(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(200),
      child: Column(
        children: <Widget>[
          _createButton("记账", context, (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return InputPage();
            }));
          }),
          _createButton("汇总", context, (){
            showDialog<Null>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return HuiZongAlertDialog(
                  showData: [
                    {"name":"王球","money":"153.00"},
                    {"name":"郑阳洁","money":"15.00"},
                    {"name":"李三凤","money":"13.00"},
                    {"name":"不吃牛的草","money":"3.00"}],
                );
              },
            ).then((val) {
              print(val);
            });
          }),
        ],
      ),
    );
  }

  Widget _createSortButton(BuildContext context) {
    return RaisedButton(
      color: Colors.orange,
      onPressed: () {
        var index = this.currentPayIndex;
        JhPickerTool.showStringPicker(context,
            data: this.payList,
            normalIndex: index,
            title: "付款人", clickCallBack: (int index, var str) {
              this.currentPayIndex = index;

              // 刷新列表
            });
      },
      child: Text("筛选"),
    );
  }

  /* 创建按钮 */
  Widget _createButton(String title, BuildContext context, Function tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(125), right: ScreenUtil().setWidth(125),top: 15),
        height: ScreenUtil().setHeight(76),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(38)))
        ),
        child: Center(
          child: Text(title, style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }

  // FutureBuilder
  Widget _createRecordsList(BuildContext context) {
    return FutureBuilder(
      future: _requestRecords(),
      builder: (context, snapshot) {
        // 有数据
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('点击开始');
          case ConnectionState.waiting:
            return Text('加载中...');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              records = snapshot.data["data"];
              print('解析数据 $snapshot.data');
              if (records != null && records.length > 0) {
                return _createListView();
              } else {
                return Center(child: Text('没有任何记录'),);
              }
            }
        }
      },
    );
  }

  // 列表
  Widget _createListView() {
    return ListView.separated(
      itemCount: records.length,
      cacheExtent: 48,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("姓名 大米", style: TextStyle(fontSize: 16.0),),
          subtitle: Text("2020-06-30 100元", style: TextStyle(color: Colors.grey, fontSize: 14),),
          contentPadding: EdgeInsets.only(left: 16),
          isThreeLine: true,
          onTap: () {
            BotToast.showText(text: "点击 $index");
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(color: Colors.black12, indent: 16.0, endIndent: 16.0,);
      },
    );
  }

  /* 请求数据 */
  Future<Map> _requestRecords() async {
    Dio dio = Dio();
    var uri = "http://192.168.73.154:3000/test";
    Response response = await dio.get(uri);
    return response.data;
  }
}
