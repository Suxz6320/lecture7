import 'package:flutter/material.dart';

import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/list_page.dart';
import 'pages/paged_page.dart';
import 'pages/stats_page.dart';

void main() {
  runApp(const AppSkeletonApp());
}

class AppSkeletonApp extends StatelessWidget {
  const AppSkeletonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app_skeleton · 可滚动组件与多页面结构',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      // 命名路由表：5 条路由全部走命名式（自主实践2：不少于 4 条）
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/list': (context) => const ListPage(),
        '/detail': (context) => const DetailPage(),
        '/paged': (context) => const PagedPage(),
        '/stats': (context) => const StatsPage(),
      },
    );
  }
}
