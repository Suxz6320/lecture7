// app_skeleton 端到端冒烟测试：
// 网格首页 → 分类列表 → 详情页（强类型传参）→ 返回 → 长按筛选 → pop 回传值 → 分页加载。
// 注：合并为单条测试是因为 flutter_test 连跑多条时，
// 后一条的 rootBundle assets 加载与 pumpAndSettle 存在已知冲突（见进度报告“问题与调试”）。
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_skeleton/main.dart';

/// 轮询 pump，直到目标组件出现（assets 加载是真实异步，耗时随运行环境波动）。
Future<void> pumpUntilFound(WidgetTester tester, Finder finder,
    {int maxPumps = 30}) async {
  for (var i = 0; i < maxPumps; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
}

void main() {
  testWidgets('end-to-end: grid home / detail / filter pop / paged list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    // ---- 步骤三：首页是 GridView 分类网格 ----
    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('编程'), findsOneWidget);
    expect(find.text('人工智能'), findsOneWidget);

    // ---- 点分类卡片进入列表页并按类别过滤 ----
    await tester.tap(find.text('编程'));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Dart程序设计基础'), findsOneWidget);
    expect(find.text('高等数学（上）'), findsNothing); // 数学类不应出现

    // ---- 步骤二：点击列表项携带 Book 实例进详情页，字段完整 ----
    await tester.tap(find.text('Dart程序设计基础'));
    await tester.pumpAndSettle();
    expect(find.text('B001'), findsOneWidget); // 编号
    expect(find.text('45 次'), findsOneWidget); // 借阅次数
    // 详情页“返回”按钮 pop（无值）
    await tester.tap(find.text('返回'));
    await tester.pumpAndSettle();
    expect(find.text('Dart程序设计基础'), findsOneWidget); // 回到列表

    // ---- 步骤三：长按弹出筛选层，选择“仅看高借阅量” ----
    await tester.longPress(find.text('Dart程序设计基础'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('仅看高借阅量（≥50次）'));
    await tester.pumpAndSettle();
    // 编程类里只有 B017(71次) ≥50，其余被过滤
    expect(find.text('Python编程从入门到实践'), findsOneWidget);
    expect(find.text('Dart程序设计基础'), findsNothing);

    // ---- 返回首页，回传值显示在 AppBar 副标题 ----
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('上次筛选：编程 · 仅看高借阅量'), findsOneWidget);

    // ---- 自主实践：分页加载，每次追加 20 条 ----
    final entry = find.text('分页加载演示');
    await tester.scrollUntilVisible(entry, 200,
        scrollable: find.byType(Scrollable).first);
    await tester.ensureVisible(entry);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(entry);
    await pumpUntilFound(tester, find.text('分页加载演示 · 已加载 20/100'));
    expect(find.text('分页加载演示 · 已加载 20/100'), findsOneWidget);

    final more = find.text('加载更多');
    await tester.scrollUntilVisible(more, 300,
        scrollable: find.byType(Scrollable).first);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(more);
    await pumpUntilFound(tester, find.text('分页加载演示 · 已加载 40/100'));
    expect(find.text('分页加载演示 · 已加载 40/100'), findsOneWidget);
  });
}
