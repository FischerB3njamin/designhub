import 'package:designhub/features/question/models/closed_question.dart';
import 'package:designhub/features/question/models/open_question.dart';
import 'package:designhub/features/question/models/question_katalog.dart';
import 'package:designhub/features/question/models/question_type.dart';
import 'package:designhub/features/question/models/roll_out_type.dart';

List<QuestionCatalog> questionKatalog = [
  QuestionCatalog(
    postId: "po-001",
    catalog: [
      OpenQuestion("Any suggestions to improve the design?", QuestionType.open,
          RollOutType.like),
      ClosedQuestion("Do you prefer a minimalist or detailed logo?",
          QuestionType.close, RollOutType.both, ["Minimalist", "Detailed"]),
    ],
  ),
  QuestionCatalog(
    postId: "po-002",
    catalog: [
      ClosedQuestion("Which typography style do you prefer?",
          QuestionType.close, RollOutType.both, ["Serif", "Sans-serif"]),
    ],
  ),
  QuestionCatalog(
    postId: "po-003",
    catalog: [
      ClosedQuestion("Do you prefer light or dark mode?", QuestionType.close,
          RollOutType.like, ["Light Mode", "Dark Mode"]),
      OpenQuestion("What improvements would you suggest?", QuestionType.open,
          RollOutType.both),
    ],
  ),
  QuestionCatalog(
    postId: "po-004",
    catalog: [
      ClosedQuestion("Do you like vibrant or pastel colors for posters?",
          QuestionType.close, RollOutType.dislike, ["Vibrant", "Pastel"]),
    ],
  ),
  QuestionCatalog(
    postId: "po-005",
    catalog: [
      OpenQuestion("What key info should always be on a business card?",
          QuestionType.open, RollOutType.like),
    ],
  ),
  QuestionCatalog(
    postId: "po-006",
    catalog: [
      ClosedQuestion(
          "How important is consistency in branding?",
          QuestionType.close,
          RollOutType.both,
          ["Very Important", "Not Important"]),
    ],
  ),
  QuestionCatalog(
    postId: "po-007",
    catalog: [
      OpenQuestion("What should a perfect landing page include?",
          QuestionType.open, RollOutType.both),
    ],
  ),
  QuestionCatalog(
    postId: "po-008",
    catalog: [
      ClosedQuestion(
          "Which color scheme suits a fantasy book cover?",
          QuestionType.close,
          RollOutType.like,
          ["Dark & Mysterious", "Bright & Magical"]),
    ],
  ),
  QuestionCatalog(
    postId: "po-009",
    catalog: [
      OpenQuestion(
          "What makes a post go viral?", QuestionType.open, RollOutType.both),
    ],
  ),
  QuestionCatalog(
    postId: "po-010",
    catalog: [
      ClosedQuestion("Do you prefer line or filled icons?", QuestionType.close,
          RollOutType.both, ["Line Icons", "Filled Icons"]),
    ],
  ),
];
