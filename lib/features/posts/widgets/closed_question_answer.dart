import 'package:flutter/material.dart';

class ClosedQuestionAnswer extends StatefulWidget {
  const ClosedQuestionAnswer({
    super.key,
    required this.isLast,
    required this.controller,
    required this.addItem,
    required this.removeItem,
    required this.index,
  });

  final bool isLast;
  final int index;
  final TextEditingController controller;
  final Function addItem;
  final Function removeItem;

  @override
  State<ClosedQuestionAnswer> createState() => _ClosedQuestionAnswerState();
}

class _ClosedQuestionAnswerState extends State<ClosedQuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(hintText: "Answer"),
            ),
          ),
          SizedBox(width: 16),
          IconButton(
            onPressed: () => widget.isLast
                ? widget.addItem()
                : widget.removeItem(widget.index),
            icon: Icon(
              widget.isLast ? Icons.add : Icons.delete,
            ),
          ),
        ],
      ),
    );
  }
}
