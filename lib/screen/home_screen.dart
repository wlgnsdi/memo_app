import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';
import 'package:memo_app/screen/add_memo_screen.dart';
import 'package:memo_app/screen/memo_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Memo> _memos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memo')),
      // body: _memoList(),
      body: ListView.builder(
        itemCount: _memos.length,
        itemBuilder: (context, index) {
          final memo = _memos[index];

          return GestureDetector(
            onTap: () {
              memoDetail(index);
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              color: Colors.grey,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text(memo.content)),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteMemo(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newMemoContent = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMemoScreen()),
          );

          if (newMemoContent is String && newMemoContent.isNotEmpty) {
            setState(() {
              _memos.add(
                Memo(content: newMemoContent, createdAt: DateTime.now()),
              );
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteMemo(int index) {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 15),
                const Text('삭제', style: TextStyle(fontSize: 20)),
                Text('삭제하시겠습니까?'),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _memos.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                        child: Text('예'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('아니오'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  void memoDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoDetailScreen(memo: _memos[index]),
      ),
    );
  }
}
