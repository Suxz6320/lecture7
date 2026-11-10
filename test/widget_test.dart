// app_skeleton 冒烟测试：验证应用能构建，列表页加载出图书数据。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_skeleton/main.dart';

void main() {
  testWidgets('list page renders books from assets', (WidgetTester tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    // 等待异步加载完成
    await tester.pumpAndSettle();

    // books.json 中的若干条目应出现在列表里。
    // 注意：ListView.builder 懒构建，只有可视区域内的条目会被渲染，
    // 因此这里断言前几条可见书目，并验证列表本身存在。
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Dart程序设计基础'), findsOneWidget);
    expect(find.text('Flutter移动应用开发'), findsOneWidget);
  });
}
