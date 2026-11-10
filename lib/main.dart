import 'package:flutter/material.dart';

import 'pages/list_page.dart';

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
      // 步骤一：先让列表页直接做首页；步骤二改命名路由表
      home: const ListPage(),
    );
  }
}
