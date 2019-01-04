import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'counter.dart';

// Stateful widget은 상태객체를 갖고있고 상태값이 변함에 따라 다시 그려진다
// Stateful widget은 state 클래스 인스턴스를 받아서 사용한다
class RandomWords extends StatefulWidget {
  RandomWords({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: _pushCounter)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  _pushSaved() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => _savedItems(context),
        ));
  }

  _pushCounter() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Counter(title: '버튼을 누르자')));
  }

  Scaffold _savedItems(context) {
    final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
      return ListTile(
          title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ));
    });
    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: ListView(children: divided));
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return const Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
