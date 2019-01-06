import 'package:flutter/material.dart';
import 'random_words.dart';
import 'counter.dart';

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    RandomWords(title: '아무단어나 고르자'),
    Counter(title: '버튼을 눌러서 숫자를 높여보자')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              title: Text('단어 선택'),
            ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.add), title: Text('카운터'))
          ]),
    );
  }

  void _onTapped(int idx) {
    setState(() {
      _currentIndex = idx;
    });
  }
}
