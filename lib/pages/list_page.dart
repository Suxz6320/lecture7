import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';
import '../widgets/book_tile.dart';

/// 步骤一：数据与列表页。
/// 从 assets/data/books.json 异步加载 20 条图书，用 ListView.builder 懒构建。
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
      appBar: AppBar(title: const Text('图书列表 · ListView.builder')),
      body: books == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, i) => BookTile(
                book: books[i],
                // 步骤二：携带强类型 Book 实例跳详情页
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: books[i],
                ),
              ),
            ),
    );
  }
}
