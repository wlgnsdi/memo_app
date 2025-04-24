import 'package:flutter/material.dart';

class MemoItem extends StatelessWidget {
  final String memo;
  final int index;
  final Function(int) deleteMemo;
  const MemoItem({
    super.key,
    required this.memo,
    required this.index,
    required this.deleteMemo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      color: Colors.grey,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(memo)),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              deleteMemo(index);
            },
          ),
        ],
      ),
    );
  }
}
