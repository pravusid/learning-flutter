import 'package:flutter/material.dart';
import 'random_words.dart';

void main() => runApp(MyApp());

// 이 위젯은 application root
// StatelessWidget은 위젯이 로드될 때 한번만 그려진다
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material Design을 쉽게 활용할 수 있는 built-in widget
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: RandomWords(title: '아무단어나 고르자'),
    );
  }
}
