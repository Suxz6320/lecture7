import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';

/// 自主实践2：第 5 条命名路由——借阅统计页。
/// 数据量小且静态，用 ListView(children: [...]) 一次构建（选型判据：两位数以内静态列表）。
class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<Book>? _books;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final raw = await rootBundle.loadString('assets/data/books.json');
    final list = (jsonDecode(raw) as List)
        .map((e) => Book.fromJson(e as Map<String, dynamic>))
        .toList();
    setState(() => _books = list);
  }

  @override
  Widget build(BuildContext context) {
    final books = _books;
    return Scaffold(
      appBar: AppBar(title: const Text('借阅统计')),
      body: books == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _summaryCard(books),
                const SizedBox(height: 16),
                ..._categories.map((cat) => _categoryRow(books, cat)),
              ],
            ),
    );
  }

  static const _categories = ['编程', '计算机', '数学', '人工智能'];

  Widget _summaryCard(List<Book> books) {
    final totalBorrow =
        books.fold<int>(0, (sum, b) => sum + b.borrowCount);
    final highCount = books.where((b) => b.borrowCount >= 50).length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('总藏书 ${books.length} 本',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('总借阅次数 $totalBorrow 次 · 高借阅（≥50次）$highCount 本'),
          ],
        ),
      ),
    );
  }

  Widget _categoryRow(List<Book> books, String cat) {
    final inCat = books.where((b) => b.category == cat).toList();
    final sum = inCat.fold<int>(0, (s, b) => s + b.borrowCount);
    final maxBorrow =
        books.fold<int>(1, (m, b) => b.borrowCount > m ? b.borrowCount : m);
    return Card(
      child: ListTile(
        title: Text('$cat · ${inCat.length} 本'),
        subtitle: LinearProgressIndicator(value: sum / (maxBorrow * inCat.length.clamp(1, 99))),
        trailing: Text('$sum 次'),
      ),
    );
  }
}
