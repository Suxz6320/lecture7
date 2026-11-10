/// Book 模型——复制自第4课 async_json/lib/book.dart（实践指南步骤一要求）。
class Book {
  final String id, title, category;
  final int borrowCount;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.borrowCount,
  });

  /// 从 JSON Map 构造 Book。
  /// 缺失字段给默认值（borrowCount 缺失按 0 处理），
  /// 数字字段用 as num 再 toInt，兼容 JSON 中 int/double 两种情况。
  factory Book.fromJson(Map<String, dynamic> j) => Book(
        id: (j['id'] as String?) ?? 'UNKNOWN',
        title: (j['title'] as String?) ?? '未命名',
        category: (j['category'] as String?) ?? '未分类',
        borrowCount: ((j['borrowCount'] as num?) ?? 0).toInt(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'borrowCount': borrowCount,
      };

  @override
  String toString() => 'Book($id, $title, $category, $borrowCount)';
}
