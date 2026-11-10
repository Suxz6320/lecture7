// app_skeleton 冒烟测试：验证三页闭环——网格首页→分类列表→筛选回传。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_skeleton/main.dart';

void main() {
  testWidgets('grid home -> filtered list -> pop with value',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    // 步骤三：首页是 GridView 分类网格
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('编程'), findsOneWidget);
    expect(find.text('人工智能'), findsOneWidget);

    // 点分类卡片进入列表页并按类别过滤
    await tester.tap(find.text('编程'));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Dart程序设计基础'), findsOneWidget);
    expect(find.text('高等数学（上）'), findsNothing); // 数学类不应出现

    // 长按弹出筛选层，选择“仅看高借阅量”
    await tester.longPress(find.text('Dart程序设计基础'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('仅看高借阅量（≥50次）'));
    await tester.pumpAndSettle();
    // 编程类里只有 B017(71次) ≥50，其余被过滤
    expect(find.text('Python编程从入门到实践'), findsOneWidget);
    expect(find.text('Dart程序设计基础'), findsNothing);

    // 返回首页，回传值显示在 AppBar 副标题
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('上次筛选：编程 · 仅看高借阅量'), findsOneWidget);
  });
}
