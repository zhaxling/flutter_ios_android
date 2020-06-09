import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("记账记录"),
        ),
        body: Stack(
          children: <Widget>[
            FutureBuilder(
              future: Dio().get("https://www.baidu.com"),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  if (snap.hasError) {
                    return Center(
                      child: Text("出错了！"),
                    );
                  }
                  return _createList(context, snap.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(40, 242, 242, 242),
                      semanticsLabel: "加载中...",
                    ),
                  );
                }
              },
            ),
            Positioned(
              right: 10,
              bottom: ScreenUtil().setHeight(100),
              child: Container(
                width: ScreenUtil().setWidth(100),
                height: ScreenUtil().setWidth(100),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(50),))
                ),
                child: GestureDetector(
                  onTap: (){
                    _createAlert(context);
                  },
                  child: Center(
                    child: Text("汇总"),
                  ),
                ),
              )
            )
          ],
        )
    );
  }

  Widget _createList(BuildContext context, dynamic data) {
    return ListView.separated(
      itemCount: 40,
      cacheExtent: 56,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("列表 $index"),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.orange,
        );
      },
    );
  }

  void _createAlert(BuildContext context) {
    Alert(
      context: context,
      title: "汇总成功",
      content: Column(
        children: <Widget>[
          Text("汇总2"),
          Text("汇总3"),
          Text("汇总4"),
          Text("汇总5"),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text("确定", style: TextStyle(
            color: Colors.white, fontSize: 20
          ),),
        )
      ]
    ).show();
  }
}

//Alert(
//context: context,
//title: "LOGIN",
//content: Column(
//children: <Widget>[
//TextField(
//decoration: InputDecoration(
//icon: Icon(Icons.account_circle),
//labelText: 'Username',
//),
//),
//TextField(
//obscureText: true,
//decoration: InputDecoration(
//icon: Icon(Icons.lock),
//labelText: 'Password',
//),
//),
//],
//),
//buttons: [
//DialogButton(
//onPressed: () => Navigator.pop(context),
//child: Text(
//"LOGIN",
//style: TextStyle(color: Colors.white, fontSize: 20),
//),
//)
//]).show();
