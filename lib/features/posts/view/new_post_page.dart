import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/section_header.dart';
import 'package:designhub/features/posts/widgets/section_image.dart';
import 'package:designhub/features/posts/widgets/section_inputfields.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/question/controller/question_controller.dart';
import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/posts/widgets/section_question.dart';
import 'package:designhub/features/question/models/roll_out_type.dart';
import 'package:flutter/material.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final _formKey = GlobalKey<FormState>();
  final postController = PostController();
  final questionController = QuestionController();
  final profileController = ProfileController();
  bool questionError = false;
  String title = '';
  String description = '';
  String hashtag = '';

  List<String> uploadedImage = [];
  List<Question> questions = [];

  void createPost() async {
    if (!_formKey.currentState!.validate() || uploadedImage.isEmpty) return;

    if (!areQuestionsValid()) {
      setState(() => questionError = true);
      return;
    }

    Post post = await _createNewPost();
    postController.createPost(post);
    questionController.addQuestionCatalog(post.postId, questions);
    profileController.addPost(post.postId);

    if (mounted) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => NavigationPage()));
    }
  }

  bool areQuestionsValid() {
    bool hasBoth =
        questions.any((question) => question.rollOut == RollOutType.both);
    bool hasLike =
        questions.any((question) => question.rollOut == RollOutType.like);
    bool hasDislike =
        questions.any((question) => question.rollOut == RollOutType.dislike);

    return questions.isNotEmpty && (hasBoth || (hasLike && hasDislike));
  }

  Future<Post> _createNewPost() async {
    return Post(
      postId: await postController.createPostId(),
      title: title,
      description: description,
      hashtags: hashtag,
      images: uploadedImage,
      userId: profileController.getCurrentProfile().userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SectionHeader(),
              SizedBox(height: 16),
              SectionInputfields(
                  titleCallback: (e) => setState(() => title = e),
                  hashtagCallback: (e) => setState(() => hashtag = e),
                  descriptionCallback: (e) => setState(() => description = e),
                  formKey: _formKey),
              SizedBox(height: 24),
              SectionImage(
                callback: (e) => setState(() => uploadedImage = e),
                uploadedImage: uploadedImage,
              ),
              SizedBox(height: 16),
              if (uploadedImage.isNotEmpty)
                SectionQuestion(callback: (e) => setState(() => questions = e)),
              if (questionError) Text("Add a question for each type!"),
              ElevatedButton(
                onPressed: questions.isEmpty ? null : createPost,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Create Post",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
