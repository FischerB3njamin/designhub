import 'package:designhub/features/posts/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
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
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Description",
              ),
            ),
            SizedBox(height: 8),
            TextField(
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
              "New Post",
              style: TextTheme.of(context).headlineLarge,
            ),
            SizedBox(height: 16),
            if (uploadedImage.isNotEmpty)
              ...uploadedImage.map((path) => ImageCard(
                    callback: removeImage,
                    imagePath: path,
                  )),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    uploadedImage.length > 2
                        ? Colors.grey
                        : Color.fromRGBO(242, 86, 25, 1)),
              ),
              onPressed: () => handleLoadImage(),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '+',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
