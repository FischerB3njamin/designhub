import 'package:designhub/features/posts/provider/post_new_notifier.dart';
import 'package:designhub/features/posts/widgets/card_custom.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionImage extends StatelessWidget {
  const SectionImage({super.key});

  @override
  Widget build(BuildContext context) {
    final newPostNotifier = context.watch<NewPostNotifier>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (newPostNotifier.uploadedImage.isNotEmpty)
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: newPostNotifier.getCrossAxisCount(),
              padding: const EdgeInsets.all(8),
              children: [
                ...newPostNotifier.uploadedImage.map((path) => CardCustom(
                      callback: newPostNotifier.removeImage,
                      imagePath: path,
                    )),
                InkWell(
                  onTap: () => newPostNotifier.uploadedImage.length < 3
                      ? newPostNotifier.handleLoadImage(context)
                      : null,
                  child: newPostNotifier.uploadedImage.length < 3
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: DesignhubColors.primary),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "+",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: DesignhubColors.primary,
                                ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        if (newPostNotifier.uploadedImage.isEmpty)
          IconButton(
            color: DesignhubColors.white,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(DesignhubColors.primary),
            ),
            onPressed: () => newPostNotifier.handleLoadImage(context),
            icon: const Icon(
              Icons.add,
              size: 28,
            ),
          ),
      ],
    );
  }
}
