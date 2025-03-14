import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:flutter/material.dart';

class SectionInputfields extends StatelessWidget {
  final Function titleCallback;
  final Function descriptionCallback;
  final Function hashtagCallback;
  final GlobalKey<FormState> formKey;
  const SectionInputfields({
    super.key,
    required this.descriptionCallback,
    required this.hashtagCallback,
    required this.titleCallback,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        TextFormField(
          onChanged: (e) => titleCallback(e),
          decoration: InputDecoration(
            hintText: "Title",
          ),
          validator: ValidationController.validateNotEmpty,
        ),
        TextFormField(
          onChanged: (e) => descriptionCallback(e),
          decoration: InputDecoration(
            hintText: "Description",
          ),
          validator: ValidationController.validateNotEmpty,
        ),
        TextFormField(
          onChanged: (e) => hashtagCallback(e),
          decoration: InputDecoration(
            hintText: "Hashtags",
          ),
          validator: ValidationController.validateNotEmpty,
        )
      ],
    );
  }
}
