import 'dart:io';

import 'package:designhub/features/core/navigation/provider/navigation_notifier.dart';
import 'package:designhub/features/content/posts/controller/post_controller.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/shared/data/image_upload_service.dart';

import 'package:designhub/shared/provider/base_provider.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostNotifier extends BaseUiProvider {
  late PostController _postController;
  late CurrentProfileNotifier _loginNotifier;
  final PageController pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Post? post;
  String title = '';
  String description = '';
  String hashtags = '';
  bool sos = false;
  List<String> uploadedImage = [];
  bool _savePost = false;
  bool _imagesDone = false;
  bool _isUploading = false;
  int _currentIndex = 0;
  final List<String> pageTitles = ['Add Metadata', 'Add Images', 'Overview'];

  final List<String> pageDescriptions = [
    'Provide the basic information for your post. Add a clear and engaging title, write a short description to explain your design, and use relevant hashtags to improve discoverability.',
    'Upload high-quality images that represent your design. You can add up to 3 images. Make sure your visuals capture the essence of your creative work.',
    ''
  ];

  NewPostNotifier(BuildContext context) {
    _postController = context.read<PostController>();
    _loginNotifier = context.read<CurrentProfileNotifier>();
  }

  int get currentIndex => _currentIndex;

  // UI-bezogene Getter
  String get currentPageTitle => pageTitles[_currentIndex];
  String get currentPageDescription => pageDescriptions[_currentIndex];
  bool get isMetadataPage => _currentIndex == 0;
  bool get isImagePage => _currentIndex == 1;
  bool get isOverview => _currentIndex == 2;
  bool get isUploading => _isUploading;
  int getCrossAxisCount() => uploadedImage.length == 1 ? 2 : 3;

  // Daten-bezogene Setter
  void setTitle(String val) => title = val;
  void setDescription(String val) => description = val;
  void setHashtag(String val) => hashtags = val;
  void setSos(bool val) {
    sos = val;
    notifyListeners();
  }

  // UI-bezogene Methoden
  void goToNextPage(BuildContext context) async {
    if (isMetadataPage) {
      if (!formKey.currentState!.validate()) return;
      _imagesDone = false;
      nextPage();
    }
    if (isImagePage) {
      if (_imagesDone) {
        _savePost = false;
        initPost();
        nextPage();
      }
      _imagesDone = true;
    }

    if (isOverview) {
      if (_savePost) {
        _isUploading = true;
        notifyListeners();
        await uploadImage();
        if (context.mounted) _createPost(context);
      }
      _savePost = true;
    }
  }

  void initPost() {
    post = Post(
        postId: '',
        title: title,
        description: description,
        hashtags: hashtags,
        images: uploadedImage,
        userId: _loginNotifier.getProfileId(),
        isSos: sos,
        isActive: true,
        created: DateTime.now());
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    _currentIndex++;
    notifyListeners();
  }

  void goToPreviousPage() {
    if (_currentIndex > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _currentIndex--;
      notifyListeners();
    }
  }

  void removeImage(String path) {
    uploadedImage.remove(path);
    notifyListeners();
  }

  Future<void> handleLoadImage(BuildContext context) async {
    String? path = await ImageUploadService.pickImage(context);
    if (path != null) {
      uploadedImage.add(path);
    }
    notifyListeners();
  }

  Future<void> uploadImage() async {
    List<String> urls = [];

    for (final i in uploadedImage) {
      urls.add(await ImageUploadService.uploadProfileImage(File(i)));
    }
    post!.images = urls;
  }

  Future<void> _createPost(BuildContext context) async {
    await runAsync(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      String postId = await _postController.createPost(post!);
      if (context.mounted) {
        context.read<CurrentProfileNotifier>().addMyPost(postId);
        context.read<NavigationNotifier>().handleIconTap(0, context);
        Navigator.of(context).pop();
      }
    });
  }
}
