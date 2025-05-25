import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/socials/profile/provider/profile_notifier.dart';
import 'package:designhub/features/socials/profile/widgets/image_picker_field.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  final Profile profile;
  const ProfileEditPage({super.key, required this.profile});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late TextEditingController nameController;
  late TextEditingController aboutMeController;
  late TextEditingController interestsController;

  late String headerImagePath;
  late String avatarImagePath;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    aboutMeController = TextEditingController(text: widget.profile.aboutMe);
    interestsController = TextEditingController(text: widget.profile.interests);
    headerImagePath = widget.profile.backgroundImagePath;
    avatarImagePath = widget.profile.avatarImagePath;
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutMeController.dispose();
    interestsController.dispose();
    super.dispose();
  }

  Future<void> _onUpdateProfilePressed() async {
    setState(() {
      _isLoading = true;
    });

    if (!(_formKey.currentState?.validate() ?? false)) return;

    final profileProvider = context.read<ProfileNotifier>();
    final updatedProfile = await profileProvider.updateProfile(
      currentProfile: widget.profile,
      name: nameController.text,
      aboutMe: aboutMeController.text,
      interests: interestsController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      profileProvider.clearTempImages();
      Navigator.pop(context, updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = context.watch<ProfileNotifier>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
            title: Text("Edit Profile"),
            leading: SizedBox.shrink(),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close)),
            ]),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    ImagePickerField(
                      title: "Header Image:",
                      imagePath: headerImagePath,
                      imageFile: profileNotifier.headerImageFile,
                      onPick: () => profileNotifier.pickImage(true, context),
                    ),
                    ImagePickerField(
                      title: "Avatar Image:",
                      imagePath: avatarImagePath,
                      imageFile: profileNotifier.avatarImageFile,
                      onPick: () => profileNotifier.pickImage(false, context),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: ValidationController.validateNotEmpty,
                    ),
                    TextFormField(
                      controller: aboutMeController,
                      maxLines: null,
                      decoration: InputDecoration(labelText: 'About me'),
                      validator: ValidationController.validateNotEmpty,
                    ),
                    TextFormField(
                      controller: interestsController,
                      maxLines: null,
                      decoration: InputDecoration(
                          labelText: 'Interests & Inspirations'),
                      validator: ValidationController.validateNotEmpty,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: DesignhubColors.black),
                      )),
                  SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 16),
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all(const Size(120, 35)),
                        backgroundColor: WidgetStateProperty.all(
                          DesignhubColors.primary,
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        ),
                      ),
                      onPressed: () => _onUpdateProfilePressed(),
                      child: _isLoading
                          ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                color: DesignhubColors.white,
                              ),
                            )
                          : Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: DesignhubColors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
