import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  static void show(
    BuildContext context,
    Widget widget,
    double height,
  ) async =>
      await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        clipBehavior: Clip.hardEdge,
        builder: (context) => CustomBottomSheet(
          widget: widget,
          height: height,
        ),
      );

  static void close(BuildContext context) {
    Navigator.pop(context);
  }

  final Widget widget;
  final double height;

  const CustomBottomSheet({
    super.key,
    required this.widget,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FractionallySizedBox(
          heightFactor: height,
          child: widget,
        ),
      ),
    );
  }
}
