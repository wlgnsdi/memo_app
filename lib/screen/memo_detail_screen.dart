import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memo_app/data/local/database_helper.dart';
import 'package:memo_app/models/memo.dart';

class MemoDetailScreen extends StatefulWidget {
  final Memo memo;

  const MemoDetailScreen({super.key, required this.memo});

  @override
  State<MemoDetailScreen> createState() => _MemoDetailScreenState();
}

class _MemoDetailScreenState extends State<MemoDetailScreen> {
  bool isEdit = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 상세'),
        actions: [
          isEdit
              ? TextButton(
                onPressed: () async {
                  Memo memo = Memo(
                    id: widget.memo.id,
                    content: _textEditingController.text,
                    createdAt: widget.memo.createdAt,
                  );

                  DatabaseHelper().updateMemo(memo);

                  setState(() {
                    isEdit = !isEdit;
                  });
                  Navigator.pop(context, memo);
                },
                child: Text('저장'),
              )
              : TextButton(
                onPressed: () {
                  setState(() {
                    isEdit = !isEdit;
                    _textEditingController.text = widget.memo.content;
                  });
                },
                child: Text('수정'),
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            !isEdit
                ? Text(
                  widget.memo.content,
                  style: const TextStyle(fontSize: 18.0),
                )
                : TextField(controller: _textEditingController),
            const SizedBox(height: 16.0),
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.memo.createdAt),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
