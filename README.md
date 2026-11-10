# app_skeleton · 第7课 可滚动组件与多页面结构

进度报告7（第9周·可滚动组件与多页面结构）配套工程。

- 姓名：李桐
- 学号：20251060003
- 仓库：https://github.com/Suxz6320/lecture7.git

## 项目简介

基于 Flutter 的多页面演示应用：GridView 分类首页、ListView.builder 图书列表、
命名路由 + 强类型传参的详情页、`pop` 回传值驱动的列表筛选，以及分页加载与分类统计两个自主实践页面。

## 运行方式

```bash
flutter pub get
flutter run -d web-server --web-port 8321
# 浏览器打开 http://localhost:8321/
```

验证：

```bash
flutter analyze   # 0 issues
flutter test      # All tests passed（端到端 widget 测试）
```

## 命名路由表（5 条）

| 路由 | 页面 | 说明 |
| --- | --- | --- |
| `/` | HomePage | GridView 分类卡片首页，AppBar 副标题展示回传值 |
| `/list` | ListPage | ListView.builder 图书列表，支持类别过滤与长按筛选弹层 |
| `/detail` | DetailPage | 详情页，`ModalRoute arguments as Book` 强类型传参 |
| `/paged` | PagedPage | 自主实践：分页加载（每页 20，共 100 条模拟数据） |
| `/stats` | StatsPage | 自主实践：按分类汇总册数与借阅量 |

## 目录结构

```
lib/
  main.dart            # 路由表与主题
  models/book.dart     # Book 数据模型（id/title/author/category/borrowCount）
  pages/               # home / list / detail / paged / stats 五个页面
  widgets/             # BookTile、CategoryCard、LoadMoreButton 三个复用组件
assets/
  data/books.json      # 20 条图书数据
```

## 数据说明

`assets/data/books.json` 内含 20 条图书记录，字段为
`id / title / author / category / borrowCount`，其中高借阅量（≥50 次）共 7 条。

## 提交记录

| 提交 | 内容 |
| --- | --- |
| 8c880d8 | chore: flutter create app_skeleton |
| aa102b5 | feat: list page with builder（步骤一） |
| 9d81be3 | feat: named routes & typed arguments（步骤二） |
| 240f9ce | feat: grid home & pop-with-value filter（步骤三） |
| 19791e1 | feat: pagination demo & stats route（自主实践） |

## AI 使用声明

本工程代码由 AI 辅助生成，本人逐行核对、运行验证，并在实验报告
"AI 使用记录"一节中如实登记提示词与采纳情况。
