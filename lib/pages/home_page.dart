import 'package:flutter/material.dart';

/// 步骤二：占位首页，仅提供进入列表页的入口。
/// 步骤三会把它改造成 GridView 分类网格首页。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('图书馆 · 首页')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/list'),
          icon: const Icon(Icons.list),
          label: const Text('查看全部图书'),
        ),
      ),
    );
  }
}
