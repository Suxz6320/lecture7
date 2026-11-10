import 'package:flutter/material.dart';

import '../models/book.dart';

/// 步骤二：详情页。
/// 通过 ModalRoute.of(context)!.settings.arguments 接收强类型 Book 实例，
/// 不使用 Map 传参，保证类型安全。
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow('图书编号', book.id),
            _infoRow('书名', book.title),
            _infoRow('分类', book.category),
            _infoRow('借阅次数', '${book.borrowCount} 次'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context), // 返回，不带值
                icon: const Icon(Icons.arrow_back),
                label: const Text('返回'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
