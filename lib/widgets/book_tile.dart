import 'package:flutter/material.dart';

import '../models/book.dart';

/// 参数化复用组件：图书列表项。
///
/// 参数化三问（指南第四节）：
/// - 哪些数据变 → [book] 进参；
/// - 哪些行为变 → [onTap] 回调进参；
/// - 样式变化少 → 固定在 build 内。
class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.book, this.onTap});

  final Book book;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.menu_book),
      title: Text(book.title),
      subtitle: Text('${book.id} · ${book.category}'),
      trailing: Text('${book.borrowCount}次'),
      onTap: onTap,
    );
  }
}
