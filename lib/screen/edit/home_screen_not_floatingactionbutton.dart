import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';
import 'package:memo_app/screen/add_memo_screen.dart';
import 'package:memo_app/screen/widget/memo_item.dart';

class HomeScreenNot extends StatefulWidget {
  const HomeScreenNot({super.key});

  @override
  State<HomeScreenNot> createState() => _HomeScreenNotState();
}

class _HomeScreenNotState extends State<HomeScreenNot> {
  final List<Memo> _memos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memo')),
      // body: _memoList(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _memos.length,
            itemBuilder: (context, index) {
              final memo = _memos[index];

              return MemoItem(
                memo: memo.content,
                index: index,
                deleteMemo: (index) {
                  _deleteMemo(index);
                },
              );
            },
          ),
          Positioned(
            bottom: 30.0,
            right: 30.0,
            child: TextButton(
              onPressed: () async {
                moveMemo();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.amber),
              ),
              child: Text('버튼'),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteMemo(int index) {
    setState(() {
      _memos.removeAt(index);
    });
  }

  Widget _memoList() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          color: Colors.grey,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex: 1, child: Text('테스트 메모1')),
              IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          color: Colors.grey,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex: 1, child: Text('테스트 메모2')),
              IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          color: Colors.grey,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex: 1, child: Text('테스트 메모3')),
              IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }

  void moveMemo() async {
    var newMemoContent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMemoScreen()),
    );

    if (newMemoContent is String && newMemoContent.isNotEmpty) {
      setState(() {
        _memos.add(Memo(content: newMemoContent, createdAt: DateTime.now()));
      });
    }
  }
}
