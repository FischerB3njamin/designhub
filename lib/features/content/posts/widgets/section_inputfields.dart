import 'package:designhub/features/content/posts/provider/post_new_notifier.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionInputfields extends StatefulWidget {
  const SectionInputfields({Key? key}) : super(key: key);

  @override
  State<SectionInputfields> createState() => _SectionInputfieldsState();
}

class _SectionInputfieldsState extends State<SectionInputfields> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _hashtagController;

  @override
  void initState() {
    super.initState();
    final newPostNotifier = context.read<NewPostNotifier>();

    // Initialize controllers with current notifier values
    _titleController = TextEditingController(text: newPostNotifier.title);
    _descriptionController =
        TextEditingController(text: newPostNotifier.description);
    _hashtagController = TextEditingController(text: newPostNotifier.hashtags);

    // Sync controllers changes to notifier
    _titleController.addListener(() {
      newPostNotifier.setTitle(_titleController.text);
    });
    _descriptionController.addListener(() {
      newPostNotifier.setDescription(_descriptionController.text);
    });
    _hashtagController.addListener(() {
      newPostNotifier.setHashtag(_hashtagController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _hashtagController.dispose();
    super.dispose();
  }

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
              controller: _titleController,
              maxLines: null,
              validator: ValidationController.validateTitle,
            ),
          ),
          const Text('Description'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _descriptionController,
              maxLines: null,
              validator: ValidationController.validateDescription,
            ),
          ),
          const Text('Hashtag'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _hashtagController,
              maxLines: null,
              validator: ValidationController.validateHashtags,
            ),
          ),
          Row(
            children: [
              Checkbox(
                activeColor: DesignhubColors.primary,
                value: newPostNotifier.sos,
                onChanged: (value) => newPostNotifier.setSos(value ?? false),
              ),
              const Text("I need help! SOS !")
            ],
          ),
        ],
      ),
    );
  }
}
