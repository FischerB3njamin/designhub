import 'package:designhub/features/posts/widgets/image_card.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  // add controller for each inputfield
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
                    (uploadedImage.length < 3
                        ? uploadedImage.length + 1
                        : 3), // Keep height consistent
                child: GridView.count(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount:
                      uploadedImage.length < 3 ? uploadedImage.length + 1 : 3,
                  children: [
                    ...uploadedImage.map((path) => ImageCard(
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
                          padding:
                              EdgeInsets.all(8), // Adds spacing inside the box
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
            // SizedBox(height: 24),
            if (uploadedImage.isNotEmpty) QuestionSection()
          ],
        ),
      ),
    ));
  }
}

class QuestionSection extends StatefulWidget {
  const QuestionSection({
    super.key,
  });

  @override
  State<QuestionSection> createState() => _QuestionSectionState();
}

class _QuestionSectionState extends State<QuestionSection> {
  List<Question> questions = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Questions",
              style: TextTheme.of(context).headlineLarge,
            ),
            IconButton(
              color: DesignhubColors.white,
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(DesignhubColors.primary),
              ),
              onPressed: () async {
                Question? question = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: FractionallySizedBox(
                      heightFactor: 0.9,
                      child: SingleChildScrollView(child: QuestionView()),
                    ),
                  ),
                );
                if (question != null) {
                  setState(() {
                    questions.add(question);
                  });
                }
              },
              icon: Icon(
                Icons.add,
                size: 28,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...questions.map((e) => QuestionOverview(question: e)),
        SizedBox(height: 16),
        ElevatedButton(
            onPressed: () {
              // print all the stuff to create a new Post :)
            },
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "create Post",
                  textAlign: TextAlign.center,
                )))
      ],
    );
  }
}

class QuestionOverview extends StatelessWidget {
  final Question question;
  const QuestionOverview({super.key, required this.question});

  Widget getRolloutIcon() {
    switch (question.rollOut) {
      case RollOutType.like:
        return Assets.icons.like.image(width: 25, height: 25);
      case RollOutType.dislike:
        return Assets.icons.dislike.image(width: 25, height: 25);
      case RollOutType.both:
        return SizedBox();
    }
  }

  Widget getQuestionTypeIcon() {
    return question.type == QuestionType.open
        ? Assets.icons.open.image(width: 25, height: 25)
        : Assets.icons.closed.image(width: 30, height: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 14,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: DesignhubColors.grey300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question.question),
                if (question.type == QuestionType.close)
                  ...((question as ClosedQuestion)
                      .answers
                      .map((answer) => Row(children: [
                            Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.55,
                              ),
                            ),
                            Text(answer)
                          ]))
                      .toList())
              ],
            ),
          ),
        ),
        Expanded(flex: 2, child: getRolloutIcon()),
        Expanded(flex: 2, child: getQuestionTypeIcon()),
      ],
    );
  }
}

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  QuestionType _selectedQuestionType = QuestionType.open;
  RollOutType _rollOutType = RollOutType.like;
  List<TextEditingController> possibleAnswers = [TextEditingController()];
  TextEditingController questionController = TextEditingController();
  void addItem() {
    if (possibleAnswers.length < 4) {
      setState(() {
        possibleAnswers.add(TextEditingController());
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      possibleAnswers.removeAt(index);
    });
  }

  void returnToOverview(bool isOpen) {
    if (isOpen) {
      Navigator.pop(
        context,
        OpenQuestion(
            questionController.text, _selectedQuestionType, _rollOutType),
      );
    } else {
      List<String> answers = possibleAnswers.map((e) => e.text).toList();
      Navigator.pop(
          context,
          ClosedQuestion(
            questionController.text,
            _selectedQuestionType,
            _rollOutType,
            answers,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 750,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Questions",
                  style: TextTheme.of(context).headlineLarge,
                ),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: questionController,
              decoration: InputDecoration(hintText: "Question"),
            ),
            SizedBox(height: 16),
            Text("When should the question been asked?"),
            SegmentedButton(
              showSelectedIcon: false,
              onSelectionChanged: (newSelection) => setState(() {
                if (newSelection.isNotEmpty) {
                  _rollOutType = newSelection.first;
                }
              }),
              emptySelectionAllowed: true,
              selected: {_rollOutType},
              segments: [
                ButtonSegment(
                  value: RollOutType.like,
                  label: Text("like"),
                ),
                ButtonSegment(
                  value: RollOutType.dislike,
                  label: Text("dislike"),
                ),
                ButtonSegment(
                  value: RollOutType.both,
                  label: Text("both"),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Which kind of question?"),
            SizedBox(height: 2),
            SegmentedButton(
              showSelectedIcon: false,
              onSelectionChanged: (newSelection) => setState(() {
                if (newSelection.isNotEmpty) {
                  _selectedQuestionType = newSelection.first;
                }
              }),
              emptySelectionAllowed: true,
              selected: {_selectedQuestionType},
              segments: [
                ButtonSegment(
                  value: QuestionType.open,
                  label: Text("open"),
                ),
                ButtonSegment(
                  value: QuestionType.close,
                  label: Text("close"),
                ),
              ],
            ),
            SizedBox(height: 24),
            if (_selectedQuestionType == QuestionType.open)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                    onPressed: () => returnToOverview(true),
                    child: Text("Add Question")),
              ),
            if (_selectedQuestionType == QuestionType.close)
              // add widget for the possible answers

              SizedBox(
                height: 350,
                child: Column(
                  children: [
                    ...possibleAnswers.map(
                      (e) => ClosedQuestionAnswer(
                          isLast: possibleAnswers.indexOf(e) ==
                              possibleAnswers.length - 1,
                          controller: e,
                          addItem: addItem,
                          removeItem: removeItem,
                          index: possibleAnswers.indexOf(e)),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => returnToOverview(false),
                      child: SizedBox(
                        width: double.infinity,
                        child:
                            Text('Add Question', textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ClosedQuestionAnswer extends StatefulWidget {
  const ClosedQuestionAnswer({
    super.key,
    required this.isLast,
    required this.controller,
    required this.addItem,
    required this.removeItem,
    required this.index,
  });

  final bool isLast;
  final int index;
  final TextEditingController controller;
  final Function addItem;
  final Function removeItem;

  @override
  State<ClosedQuestionAnswer> createState() => _ClosedQuestionAnswerState();
}

class _ClosedQuestionAnswerState extends State<ClosedQuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(hintText: "Answer"),
            ),
          ),
          SizedBox(width: 16),
          IconButton(
              onPressed: () => widget.isLast
                  ? widget.addItem()
                  : widget.removeItem(widget.index),
              icon: Icon(widget.isLast ? Icons.add : Icons.delete)),
        ],
      ),
    );
  }
}

abstract class Question {
  String question;
  QuestionType type;
  RollOutType rollOut;

  Question(this.question, this.type, this.rollOut);
}

class ClosedQuestion extends Question {
  List<String> answers;

  ClosedQuestion(
    super.question,
    super.type,
    super.rollOut,
    this.answers,
  );
}

class OpenQuestion extends Question {
  OpenQuestion(
    super.question,
    super.type,
    super.rollOut,
  );
}

enum QuestionType { open, close }

enum RollOutType {
  like,
  dislike,
  both,
}
