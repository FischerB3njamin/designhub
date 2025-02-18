import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/question/controller/question_controller.dart';
import 'package:designhub/features/question/models/question.dart';
import 'package:designhub/features/posts/widgets/card_custom.dart';
import 'package:designhub/features/posts/widgets/section_question.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final postController = PostController();
  final questionController = QuestionController();
  final profileController = ProfileController();

  String title = '';
  String description = '';
  String hashtag = '';

  List<String> uploadedImage = [];
  List<Question> questions = [];

  void createPost() {
    Post post = Post(
        postId: postController.createPostId(),
        title: title,
        description: description,
        hashtags: hashtag,
        images: uploadedImage,
        userId: profileController.getCurrentProfile().userId);

    postController.createPost(post);
    // add question
    questionController.addQuestionCatalog(post.postId, questions);

    // add it to the profile
    profileController.addPost(post.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SectionHeader(),
            SizedBox(height: 16),
            SectionInputfields(
              titleCallback: (e) => setState(() => title = e),
              hashtagCallback: (e) => setState(() => hashtag = e),
              descriptionCallback: (e) => setState(() => description = e),
            ),
            SizedBox(height: 24),
            SectionImage(
              callback: (e) => setState(() => uploadedImage = e),
              uploadedImage: uploadedImage,
            ),
            SizedBox(height: 16),
            if (uploadedImage.isNotEmpty)
              SectionQuestion(callback: (e) => setState(() => questions = e)),
            ElevatedButton(
              onPressed: createPost,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "create Post",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SectionImage extends StatelessWidget {
  final List<String> uploadedImage;
  final Function callback;

  const SectionImage({
    super.key,
    required this.uploadedImage,
    required this.callback,
  });

  Future<XFile?> loadImage() async {
    final XFile? media = await ImagePicker().pickMedia();
    return media;
  }

  void removeImage(String imagePath) {
    uploadedImage.remove(imagePath);
    callback(uploadedImage);
  }

  void handleLoadImage() async {
    if (uploadedImage.length <= 2) {
      XFile? newMedia = await loadImage();
      if (newMedia != null) {
        // uploadedImage.add(newMedia.path);
        uploadedImage.add(
            "https://images.unsplash.com/photo-1739582814657-10931286d7a5?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
        callback(uploadedImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Add Images",
          style: TextTheme.of(context).headlineLarge,
        ),
        SizedBox(height: 16),
        if (uploadedImage.isNotEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.width /
                (uploadedImage.length < 3 ? uploadedImage.length + 1 : 3),
            child: GridView.count(
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              crossAxisCount:
                  uploadedImage.length < 3 ? uploadedImage.length + 1 : 3,
              children: [
                ...uploadedImage.map((path) => CardCustom(
                      callback: removeImage,
                      imagePath: path,
                    )),
                if (uploadedImage.length < 3)
                  InkWell(
                    onTap: () => handleLoadImage(),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: DesignhubColors.primary),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "+",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: DesignhubColors.primary,
                                ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        if (uploadedImage.isEmpty)
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  uploadedImage.length > 2
                      ? DesignhubColors.grey
                      : DesignhubColors.primary),
            ),
            onPressed: () => handleLoadImage(),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '+',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: DesignhubColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
          )
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("New Post", style: TextTheme.of(context).headlineLarge),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close))
      ],
    );
  }
}

class SectionInputfields extends StatelessWidget {
  final Function titleCallback;
  final Function descriptionCallback;
  final Function hashtagCallback;
  const SectionInputfields({
    super.key,
    required this.descriptionCallback,
    required this.hashtagCallback,
    required this.titleCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (e) => titleCallback(e),
          decoration: InputDecoration(
            hintText: "Title",
          ),
        ),
        SizedBox(height: 8),
        TextField(
          onChanged: (e) => descriptionCallback(e),
          decoration: InputDecoration(
            hintText: "Description",
          ),
        ),
        SizedBox(height: 8),
        TextField(
          onChanged: (e) => hashtagCallback(e),
          decoration: InputDecoration(
            hintText: "Hashtags",
          ),
        )
      ],
    );
  }
}
