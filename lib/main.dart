import 'package:flutter/material.dart';

import 'pages/detail_page.dart';
import 'pages/home_page.dart';
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
      // 步骤二：注册命名路由表，全部使用命名路由跳转
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/list': (context) => const ListPage(),
        '/detail': (context) => const DetailPage(),
      },
    );
  }
}
