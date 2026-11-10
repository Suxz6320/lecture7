// app_skeleton 冒烟测试：验证应用能构建，命名路由可进入列表页并加载图书数据。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_skeleton/main.dart';

void main() {
  testWidgets('named route /list renders books from assets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    // 首页点击入口进入 /list
    await tester.tap(find.text('查看全部图书'));
    await tester.pumpAndSettle();

    // 注意：ListView.builder 懒构建，只有可视区域内的条目会被渲染，
    // 因此这里断言前几条可见书目，并验证列表本身存在。
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Dart程序设计基础'), findsOneWidget);
    expect(find.text('Flutter移动应用开发'), findsOneWidget);
  });
}
