import 'package:flutter/material.dart';

/// 参数化复用组件之三：分页列表底部的“加载更多”按钮。
/// 三种状态：可加载 / 加载中 / 已加载全部。
class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
    required this.loading,
    required this.exhausted,
    this.onPressed,
  });

  final bool loading;
  final bool exhausted;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (exhausted) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text('已加载全部', style: TextStyle(color: Colors.grey))),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: loading
            ? const SizedBox(
                width: 24, height: 24, child: CircularProgressIndicator())
            : FilledButton.tonalIcon(
                onPressed: onPressed,
                icon: const Icon(Icons.expand_more),
                label: const Text('加载更多'),
              ),
      ),
    );
  }
}
