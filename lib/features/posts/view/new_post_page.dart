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
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _hashtag = TextEditingController();

  List<String> uploadedImage = [];

  void handleLoadImage() async {
    if (uploadedImage.length <= 2) {
      XFile? newMedia = await loadImage();
      if (newMedia != null) {
        setState(() {
          uploadedImage.add(newMedia.path);
        });
      }
    }
  }

  Future<XFile?> loadImage() async {
    final XFile? media = await ImagePicker().pickMedia();
    return media;
  }

  void removeImage(String imagePath) => setState(() {
        uploadedImage.remove(imagePath);
      });

  void createPost() {}
  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _hashtag.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("New Post", style: TextTheme.of(context).headlineLarge),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _description,
              decoration: InputDecoration(
                hintText: "Description",
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _hashtag,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(0, 0, 0, .06),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    gapPadding: 16,
                    borderSide: BorderSide.none),
                hintText: "Hashtags",
              ),
            ),
            SizedBox(height: 24),
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
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
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
              ),
            if (uploadedImage.isNotEmpty) SectionQuestion(),
          ],
        ),
      ),
    ));
  }
}
