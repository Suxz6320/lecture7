import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';
import '../widgets/book_tile.dart';

/// 列表页：ListView.builder 懒构建。
/// 步骤三：接收首页传来的类别参数并按类别过滤；
/// 长按列表项弹出筛选层（全部 / 仅看高借阅量），
/// 返回时把当前筛选结果 pop 回首页。
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Book>? _books;
  String _category = '全部';
  bool _highOnly = false; // 仅看高借阅量（≥50次）

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 去程传参：接收首页 GridView 卡片带来的类别（强类型 String）
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is String) _category = args;
  }

  Future<void> _load() async {
    final raw = await rootBundle.loadString('assets/data/books.json');
    final list = (jsonDecode(raw) as List)
        .map((e) => Book.fromJson(e as Map<String, dynamic>))
        .toList();
    setState(() => _books = list);
  }

  String get _filterLabel =>
      '$_category · ${_highOnly ? '仅看高借阅量' : '全部'}';

  List<Book> get _visible {
    final books = _books ?? [];
    return books
        .where((b) => _category == '全部' || b.category == _category)
        .where((b) => !_highOnly || b.borrowCount >= 50)
        .toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('全部'),
              trailing: _highOnly ? null : const Icon(Icons.check),
              onTap: () {
                setState(() => _highOnly = false);
                Navigator.pop(sheetContext);
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('仅看高借阅量（≥50次）'),
              trailing: _highOnly ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _highOnly = true);
                Navigator.pop(sheetContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = _visible;
    return Scaffold(
      appBar: AppBar(
        // 返回首页时带回传值：当前筛选结果
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _filterLabel),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$_category · 图书列表'),
            Text(
              _highOnly ? '仅看高借阅量（≥50次）' : '全部',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
      body: _books == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, i) => BookTile(
                book: books[i],
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: books[i],
                ),
                // 长按弹出筛选层
                onLongPress: _showFilterSheet,
              ),
            ),
    );
  }
}
