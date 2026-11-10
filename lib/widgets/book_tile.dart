import 'package:flutter/material.dart';

import '../models/book.dart';

/// 参数化复用组件之一：图书列表项。
/// 数据进参（book），行为回调（onTap / onLongPress），样式用默认值。
class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.book, this.onTap, this.onLongPress});

  final Book book;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.menu_book),
      title: Text(book.title),
      subtitle: Text('${book.id} · ${book.category}'),
      trailing: Text('${book.borrowCount}次'),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
