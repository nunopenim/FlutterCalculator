import 'dart:async';
import 'package:expressions/expressions.dart';

class Calculator {
  String _content;
  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;

  void onRecieveSymbol(symbol) {
    _content = _content == null ? symbol : _content += symbol;
    _input.add(_content);
  }

  void onEquals() {
    final expression = Expression.parse(_content);
    _content = ExpressionEvaluator().eval(expression, null).toString();
    _input.add(_content);
  }

  void onPressingC() {
    _content = "0";
    _input.add(_content);
  }

  void onPressingBackButton() {
    if(_content != "0") {
      _content = _content.substring(0, _content.length - 1);
    }
    if (_content == "") {
      _content == "0";
    }
    _input.add(_content);
  }

  void dispose() => _controller.close();

}