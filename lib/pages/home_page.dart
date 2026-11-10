import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';
import '../widgets/category_card.dart';

/// 步骤三：GridView 分类网格首页。
/// 点分类卡片进入列表页并按类别过滤；列表页返回时把筛选结果 pop 回来，
/// 显示在 AppBar 副标题（回传值验证）。
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book>? _books;
  String? _lastFilter; // 从列表页 pop 回来的回传值

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

  Future<void> _openCategory(String category) async {
    // 去程强类型传参（String 类别）；回程用 await 接住 pop 返回值
    final result =
        await Navigator.pushNamed(context, '/list', arguments: category);
    if (result is String) {
      setState(() => _lastFilter = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final books = _books;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('图书馆 · 分类首页'),
            if (_lastFilter != null)
              Text(
                '上次筛选：$_lastFilter',
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
          ],
        ),
      ),
      body: books == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: _categories.length + 3,
              itemBuilder: (context, i) {
                if (i == _categories.length) {
                  // 全部图书入口
                  return CategoryCard(
                    title: '全部图书',
                    subtitle: '${books.length} 本',
                    icon: Icons.library_books,
                    color: Colors.indigo,
                    onTap: () => _openCategory('全部'),
                  );
                }
                if (i == _categories.length + 1) {
                  // 自主实践1：分页加载演示入口
                  return CategoryCard(
                    title: '分页加载演示',
                    subtitle: '每次追加 20 条',
                    icon: Icons.expand_more,
                    color: Colors.deepOrange,
                    onTap: () => Navigator.pushNamed(context, '/paged'),
                  );
                }
                if (i == _categories.length + 2) {
                  // 自主实践2：第 5 条路由——借阅统计
                  return CategoryCard(
                    title: '借阅统计',
                    subtitle: '各分类汇总',
                    icon: Icons.bar_chart,
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/stats'),
                  );
                }
                final cat = _categories[i];
                final count =
                    books.where((b) => b.category == cat).length;
                return CategoryCard(
                  title: cat,
                  subtitle: '$count 本',
                  icon: _categoryIcon(cat),
                  color: _categoryColor(cat),
                  onTap: () => _openCategory(cat),
                );
              },
            ),
    );
  }

  static const _categories = ['编程', '计算机', '数学', '人工智能'];

  IconData _categoryIcon(String cat) => switch (cat) {
        '编程' => Icons.code,
        '计算机' => Icons.computer,
        '数学' => Icons.calculate,
        '人工智能' => Icons.smart_toy,
        _ => Icons.category,
      };

  Color _categoryColor(String cat) => switch (cat) {
        '编程' => Colors.teal,
        '计算机' => Colors.blue,
        '数学' => Colors.orange,
        '人工智能' => Colors.purple,
        _ => Colors.grey,
      };
}
