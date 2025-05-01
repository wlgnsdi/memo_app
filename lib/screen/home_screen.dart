import 'package:flutter/material.dart';
import 'package:memo_app/data/local/database_helper.dart';
import 'package:memo_app/models/memo.dart';
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var list = await DatabaseHelper().getMemos();
      setState(() {
        _memos.addAll(list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memo')),
      body: ListView.builder(
        itemCount: _memos.length,
        itemBuilder: (context, index) {
          final memo = _memos[index];

          return GestureDetector(
            onTap: () async {
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
          var newMemo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMemoScreen()),
          );

          if (newMemo is Memo) {
            setState(() {
              _memos.add(newMemo);
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
                        onPressed: () async {
                          int isDeleted = await DatabaseHelper().deleteMemo(
                            _memos[index].id!,
                          );
                          if (isDeleted > 0) {
                            setState(() {
                              _memos.removeAt(index);
                            });
                          }
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

  void memoDetail(int index) async {
    var memo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemoDetailScreen(memo: _memos[index]),
      ),
    );

    if (memo is Memo) {
      setState(() {
        _memos[index] = memo;
      });
    }
  }
}
