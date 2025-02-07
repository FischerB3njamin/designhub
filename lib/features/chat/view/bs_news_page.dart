import 'package:designhub/features/chat/widgets/news_view.dart';
import 'package:flutter/material.dart';

class BsNewsPage extends StatelessWidget {
  const BsNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 60,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
          heightFactor: 1, child: NewsView(smallView: false)),
    );
  }
}
