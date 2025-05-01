import 'package:flutter/material.dart';
import 'package:memo_app/data/local/database_helper.dart';
import 'package:memo_app/models/memo.dart';

class AddMemoScreen extends StatefulWidget {
  const AddMemoScreen({super.key});

  @override
  State<AddMemoScreen> createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends State<AddMemoScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새로운 메모')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: '메모를 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String memoContent = _textEditingController.text.trim();
                if (memoContent.isNotEmpty) {
                  Memo memo = Memo(
                    content: memoContent,
                    createdAt: DateTime.now(),
                  );
                  DatabaseHelper().insertMemo(memo);
                  Navigator.pop(context, memo);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('메모 내용을 입력해주세요.')),
                  );
                }
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
