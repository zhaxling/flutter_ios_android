import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  TextEditingController _textEditingController = TextEditingController();

  String _radio = "球";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
      ),
      body: Container(
          child: Stack(
            children: <Widget>[
              _createRadio(context),
              _moneyTextField(context),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: _button(context)
              ),
            ],
          )
      ),
    );
  }

  Widget _createRadio(BuildContext context) {
    return Positioned(
      left: 25,
      right: 25,
      top: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: "球",
                groupValue: this._radio,
                onChanged: (value) {
                  setState(() {
                    this._radio = value;
                  });
                },
              ),
              Text("球"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: "胖",
                groupValue: this._radio,
                onChanged: (value) {
                  setState(() {
                    this._radio = value;
                  });
                },
              ),
              Text("胖"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: "凤",
                groupValue: this._radio,
                onChanged: (value) {
                  setState(() {
                    this._radio = value;
                  });
                },
              ),
              Text("凤"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: "查",
                groupValue: this._radio,
                onChanged: (value) {
                  setState(() {
                    this._radio = value;
                  });
                },
              ),
              Text("查"),
            ],
          )
        ],
      )
    );
  }

  // 输入框
  Widget _moneyTextField(BuildContext context) {
    return Positioned(
      left: 25,
      right: 25,
      height: 38,
      top: MediaQuery.of(context).size.height * 0.5,
      child: TextField(
        controller: _textEditingController,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          labelText: "金额",
          hintText: "请输入金额",
          labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        textInputAction: TextInputAction.done,
        onChanged: (String content){
          print(content);
        },
        cursorColor: Colors.purple,
        cursorWidth: 2,
        cursorRadius: Radius.elliptical(2, 8),
      ),
    );
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
          borderRadius: BorderRadius.all(Radius.circular(MediaQuery
              .of(context)
              .size
              .width * 0.2))
      ),
    );
  }

  Future<void> commit() async {
    var dic = {"id":"123"};
    var dio = Dio();
    Response response = await dio.get("http://www.baidu.com", queryParameters: dic );
    print(response.data);
  }
}
