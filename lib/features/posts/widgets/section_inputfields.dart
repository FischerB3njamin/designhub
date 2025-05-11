import 'package:designhub/features/posts/provider/post_new_notifier.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionInputfields extends StatelessWidget {
  const SectionInputfields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newPostNotifier = context.watch<NewPostNotifier>();

    return Form(
      key: newPostNotifier.formKey,
      child: ListView(
        children: [
          const Text('Title'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              maxLines: null,
              onChanged: (e) => newPostNotifier.setTitle(e),
              validator: ValidationController.validateTitle,
            ),
          ),
          const Text('Description'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              maxLines: null,
              onChanged: (e) => newPostNotifier.setDescription(e),
              validator: ValidationController.validateDescription,
            ),
          ),
          const Text('Hashtag'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              maxLines: null,
              onChanged: (e) => newPostNotifier.setHashtag(e),
              validator: ValidationController.validateHashtags,
            ),
          ),
          Row(
            children: [
              Checkbox(
                  activeColor: DesignhubColors.primary,
                  value: newPostNotifier.sos,
                  onChanged: (value) => newPostNotifier.setSos(value ?? false)),
              Text("I need help! SOS !")
            ],
          ),
        ],
      ),
    );
  }
}
