import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streams_provider/streams_provider.dart';
import 'package:test/test.dart';

class Test {
  Test() {
    stream = controller.textStream();
  }
  final controller = TextEditingController(text: "default");
  // ignore: close_sinks
  late BehaviorSubject stream;
}

void main() {
  late TextEditingController controller;
  setUp(() {
    controller = TextEditingController(text: "default");
  });

  test("#1 textStream()", () async {
    final stream = controller.textStream();

    stream.add("a");
    await Future.delayed(Duration(microseconds: 1));
    expect(controller.text, equals("a"));

    controller.text = "b";
    expect(stream.value, equals("b"));
    stream.close();
  });

  test("#2 selectionStream()", () async {
    final stream = controller.selectionStream();

    stream.add(TextSelection(baseOffset: 0, extentOffset: 0));
    await Future.delayed(Duration(microseconds: 1));
    expect(controller.selection, equals(stream.value));

    controller.selection = TextSelection(baseOffset: 1, extentOffset: 1);
    expect(stream.value, equals(controller.selection));
    stream.close();
  });

  test("#3 valueStream()", () async {
    final stream = controller.valueStream();

    stream.add(TextEditingValue(text: "a"));
    await Future.delayed(Duration(microseconds: 1));
    expect(controller.value, equals(stream.value));

    controller.value = TextEditingValue(text: "b");
    expect(stream.value, equals(controller.value));
    stream.close();
  });
}
