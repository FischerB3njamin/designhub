import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final Profile profile;
  const ProfileEditPage({
    super.key,
    required this.profile,
  });
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController aboutMeController;
  late TextEditingController interestsController;
  late TextEditingController headerImageController;
  late TextEditingController avatarImageController;
  late TextEditingController nameController;
  ProfileController profileController = ProfileController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    aboutMeController = TextEditingController(text: widget.profile.aboutMe);
    interestsController = TextEditingController(text: widget.profile.interests);
    headerImageController =
        TextEditingController(text: widget.profile.backgroundImagePath);
    avatarImageController =
        TextEditingController(text: widget.profile.avatarImagePath);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    aboutMeController.dispose();
    interestsController.dispose();
    headerImageController.dispose();
    avatarImageController.dispose();
  }

  void updateProfile() async {
    final newProfile = widget.profile;
    newProfile.name = nameController.text;
    newProfile.aboutMe = aboutMeController.text;
    newProfile.interests = interestsController.text;
    newProfile.backgroundImagePath = headerImageController.text;
    newProfile.avatarImagePath = avatarImageController.text;
    await profileController.updateProfile(widget.profile, newProfile);
    if (mounted) Navigator.pop(context, newProfile);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Profile",
              style: TextTheme.of(context).headlineLarge,
            ),
            Form(
              key: _formKey, // Attach the form key here
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) => ValidationController.validateNotEmpty(
                        value), // Validate URL format
                  ),
                  TextFormField(
                    controller: headerImageController,
                    decoration: InputDecoration(labelText: 'Header Image:'),
                    validator: (value) => ValidationController.validateUrl(
                        value), // Validate URL format
                  ),
                  TextFormField(
                    controller: avatarImageController,
                    decoration: InputDecoration(labelText: 'Avatar Image:'),
                    validator: (value) => ValidationController.validateUrl(
                        value), // Validate URL format
                  ),
                  TextFormField(
                    controller: aboutMeController,
                    maxLines: null,
                    decoration: InputDecoration(labelText: 'About me:'),
                    validator: (value) => ValidationController.validateNotEmpty(
                        value), // Check if non-empty
                  ),
                  TextFormField(
                    controller: interestsController,
                    maxLines: null,
                    decoration:
                        InputDecoration(labelText: 'Interests & Inspirations'),
                    validator: (value) => ValidationController.validateNotEmpty(
                        value), // Check if non-empty
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                SizedBox(width: 60),
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0))),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // If the form is valid, proceed with the save
                          updateProfile();
                        }
                      },
                      child: Text("Save")),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
