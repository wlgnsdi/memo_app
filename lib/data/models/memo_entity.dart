class MemoEntity {
  static const String columnId = 'id';
  static const String columnContent = 'content';
  static const String columnCreatedAt = 'createdAt';

  final int? id;
  final String content;
  final String createdAt;

  MemoEntity({this.id, required this.content, required this.createdAt});

  factory MemoEntity.fromMap(Map<String, dynamic> map) {
    return MemoEntity(
      id: map[columnId] as int?,
      content: map[columnContent] as String,
      createdAt: map[columnCreatedAt] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {columnId: id, columnContent: content, columnCreatedAt: createdAt};
  }
}
