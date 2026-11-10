import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';
import '../widgets/book_tile.dart';
import '../widgets/load_more_button.dart';

/// 自主实践1：列表分页模拟。
/// 模拟远端 100 条数据（由 20 条基础图书复制 5 批生成），
/// 首次渲染 20 条，点“加载更多”每次再追加 20 条，5 次后显示“已加载全部”。
class PagedPage extends StatefulWidget {
  const PagedPage({super.key});

  @override
  State<PagedPage> createState() => _PagedPageState();
}

class _PagedPageState extends State<PagedPage> {
  static const _pageSize = 20;

  List<Book>? _source; // 模拟的远端全量数据（100条）
  int _shown = 0; // 当前已加载条数
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final raw = await rootBundle.loadString('assets/data/books.json');
    final base = (jsonDecode(raw) as List)
        .map((e) => Book.fromJson(e as Map<String, dynamic>))
        .toList();
    // 模拟远端 100 条：基础 20 条 × 5 批
    final simulated = List<Book>.generate(100, (i) {
      final b = base[i % base.length];
      return Book(
        id: 'P${(i + 1).toString().padLeft(3, '0')}',
        title: '${b.title}（第${i ~/ base.length + 1}批）',
        category: b.category,
        borrowCount: b.borrowCount,
      );
    });
    setState(() {
      _source = simulated;
      _shown = _pageSize; // 首页 20 条
    });
  }

  Future<void> _loadMore() async {
    setState(() => _loadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 600)); // 模拟网络
    setState(() {
      _shown = (_shown + _pageSize).clamp(0, _source!.length);
      _loadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = _source;
    return Scaffold(
      appBar: AppBar(title: Text('分页加载演示 · 已加载 $_shown/100')),
      body: source == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _shown + 1, // 最后一格放“加载更多”
              itemBuilder: (context, i) {
                if (i == _shown) {
                  return LoadMoreButton(
                    loading: _loadingMore,
                    exhausted: _shown >= source.length,
                    onPressed: _loadMore,
                  );
                }
                return BookTile(
                  book: source[i],
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: source[i],
                  ),
                );
              },
            ),
    );
  }
}
