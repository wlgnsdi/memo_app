import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memo_app/model/memo.dart';

class MemoDetailScreen extends StatelessWidget {
  final Memo memo;

  const MemoDetailScreen({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메모 상세')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(memo.content, style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 16.0),
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(memo.createdAt),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
