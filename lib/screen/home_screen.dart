import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';
import 'package:memo_app/screen/add_memo_screen.dart';

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
      body: ListView.builder(
        itemCount: _memos.length,
        itemBuilder: (context, index) {
          final memo = _memos[index];

          return Container(
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
    setState(() {
      _memos.removeAt(index);
    });
  }
}
