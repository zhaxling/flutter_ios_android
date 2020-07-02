import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_ios_android_module/global/MoneyInputDialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'global/jhPickerTool.dart';
import 'pages/AlertBottomPage.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController _textEditingController = TextEditingController();

  String _radio = "球";

  // 付款人
  var payList = ["王球", "李三凤", "郑阳洁", "不吃牛的草"];
  var currentPayIndex = -1;

  // 日期
  var date = DateTime.now();

  // 承担人
  var shares = (1 << 3) + (1 << 2) + (1 << 1) + 1;

  // 金额
  var money = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          _createList(context),
          Positioned(
              bottom: ScreenUtil().setHeight(88),
              left: ScreenUtil().setWidth(25),
              right: ScreenUtil().setWidth(25),
              height: ScreenUtil().setWidth(76),
              child: _button(context)),
        ],
      )),
    );
  }

  // 列表
  Widget _createList(BuildContext context) {
    return Positioned(
      left: ScreenUtil().setWidth(25),
      right: ScreenUtil().setWidth(25),
      height: 400,
      bottom: ScreenUtil().setHeight(120),
      child: ListView.separated(
        itemBuilder: (context, index) {
          // 付款人
          if (index == 0) {
            var text = this.currentPayIndex >= 0
                ? this.payList[this.currentPayIndex]
                : "";
            return _createItem("付款人", text, () {
              selectPay(context);
            });
          }
          // 日期
          if (index == 1) {
            return _createItem(
                "付款日期", formatDate(this.date, [yyyy, '-', mm, '-', dd]), () {
              selectDate();
            });
          }
          // 分摊人
          if (index == 2) {
            return _createItem("分摊人", _getSharePeopleString(), () {
              _selectSharePeople(context);
            });
          }
          // 付款金额
          return _createItem("金额", this.money, () {
            _moneyInput(context);
          });
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black12,
            indent: 16.0,
            endIndent: 16.0,
          );
        },
        itemCount: 4,
        cacheExtent: 48,
      ),
    );
  }

  // item
  Widget _createItem(String title, String subTitle, Function tap) {
    return GestureDetector(
      // 解决GestureDetector点击空白区域无反应
      behavior: HitTestBehavior.opaque,
      onTap: tap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            child: Text(subTitle, style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }

  // 输入框
  void _moneyInput(BuildContext context) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MoneyInputDialog(
          title: "请输入金额",
          negativeText: "取消",
          positiveText: "确定",
          onCloseEvent: (){

          },
          onPositivePressEvent: (value) {
              setState(() {
                this.money = value;
              });
          },
        );
      },
    ).then((val) {
      print(val);
    });
  }

  // 提交按钮
  Widget _button(BuildContext context) {
    return FlatButton(
      onPressed: () {
        print(_textEditingController.text);

        commit();
      },
      child: Text("提交"),
      color: Colors.orange,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setWidth(38)))),
    );
  }

  // 提交
  Future<void> commit() async {
    var dic = {"id": "123"};
    var dio = Dio();
    Response response =
        await dio.get("http://www.baidu.com", queryParameters: dic);
    print(response.data);
  }

  // 选择日期
  void selectDate() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 1, 1),
        maxTime: DateTime.now(), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      setState(() {
        this.date = date;
      });
    }, currentTime: this.date, locale: LocaleType.zh);
  }

  // 选择付款人
  void selectPay(BuildContext context) {
    var index = this.currentPayIndex >= 0 ? this.currentPayIndex : 0;
    JhPickerTool.showStringPicker(context,
        data: this.payList,
        normalIndex: index,
        title: "请选择付款人", clickCallBack: (int index, var str) {
      setState(() {
        this.currentPayIndex = index;
      });
    });
  }

  // 选择分摊人
  void _selectSharePeople(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10)),
        builder: (BuildContext context) {
          return AlertBottomWidget(
            chooseValue: this.shares,
            items: this.payList,
            chooseCallback: (index) {
              setState(() {
                this.shares = index;
              });
              print('当前点击的索引值$index');
            },
          );
        });
  }

  // 计算分摊人
  String _getSharePeopleString() {
    print(this.shares);
    if ((this.shares & 1 << 4) > 0) {
      return "所有人";
    }
    String text = "";
    if ((this.shares & 1 << 3) > 0) {
      text += this.payList[0];
    }
    if ((this.shares & 1 << 2) > 0) {
      if (text.length > 0) text += ",";
      text += this.payList[1];
    }
    if ((this.shares & 1 << 1) > 0) {
      if (text.length > 0) text += ",";
      text += this.payList[2];
    }
    if ((this.shares & 1) > 0) {
      if (text.length > 0) text += ",";
      text += this.payList[3];
    }
    return text;
  }
}
