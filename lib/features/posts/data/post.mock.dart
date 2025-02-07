import 'package:designhub/features/posts/models/closed_question.dart';
import 'package:designhub/features/posts/models/open_question.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/models/question_type.dart';
import 'package:designhub/features/posts/models/roll_out_type.dart';

List<Post> samplePosts = [
  Post(
    postId: "po-001",
    title: "Modern Logo Design",
    description: "Working on a sleek, modern logo. What do you think?",
    hashtags: "#graphicdesign #logo #branding",
    images: [
      "https://plus.unsplash.com/premium_photo-1668051040456-24c63abd95b4?q=80&w=2776&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1640062905657-f9174cd5fdc9?q=80&w=2160&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    ],
    questions: [
      OpenQuestion("Any suggestions to improve the design?", QuestionType.open,
          RollOutType.like),
      ClosedQuestion("Do you prefer a minimalist or detailed logo?",
          QuestionType.close, RollOutType.both, ["Minimalist", "Detailed"]),
    ],
    creatorName: "Liam",
    creatorImage:
        "https://plus.unsplash.com/premium_photo-1671656349218-5218444643d8?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0004",
  ),
  Post(
    postId: "po-002",
    title: "Typography Exploration",
    description:
        "Experimenting with new font combinations. Which one stands out?",
    hashtags: "#typography #design #fonts",
    images: [
      "https://i.pinimg.com/736x/7c/54/fb/7c54fbebca7b9fe9253efe7ec822625c.jpg",
      "https://i.pinimg.com/736x/8b/c3/d3/8bc3d3d277fdbe03cdb8f180b1b05c5e.jpg"
    ],
    questions: [
      ClosedQuestion("Which typography style do you prefer?",
          QuestionType.close, RollOutType.both, ["Serif", "Sans-serif"]),
    ],
    creatorName: "Emma",
    creatorImage:
        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=2564&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0003",
  ),
  Post(
    postId: "po-003",
    title: "UI/UX Dashboard Concept",
    description: "A new dark-mode dashboard UI concept for an analytics app.",
    hashtags: "#UIUX #design #dashboard",
    images: [
      "https://i.pinimg.com/736x/8a/39/a4/8a39a447469f8f588079b4730b07bb0b.jpg",
      "https://i.pinimg.com/736x/5d/78/4d/5d784debc691ee34cdb96b516de5ef64.jpg"
    ],
    questions: [
      ClosedQuestion("Do you prefer light or dark mode?", QuestionType.close,
          RollOutType.like, ["Light Mode", "Dark Mode"]),
      OpenQuestion("What improvements would you suggest?", QuestionType.open,
          RollOutType.both),
    ],
    creatorName: "Emma",
    creatorImage:
        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=2564&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0003",
  ),
  Post(
    postId: "po-004",
    title: "Creative Poster Design",
    description: "Exploring bold colors and abstract shapes for a poster.",
    hashtags: "#posterdesign #creativity #art",
    images: [
      "https://i.pinimg.com/736x/08/2b/ec/082becda18f272f7d34fda07872d892a.jpg",
      "https://i.pinimg.com/736x/26/09/46/26094672255eeb587db20074b9425ced.jpg"
    ],
    questions: [
      ClosedQuestion("Do you like vibrant or pastel colors for posters?",
          QuestionType.close, RollOutType.dislike, ["Vibrant", "Pastel"]),
    ],
    creatorName: "Emma",
    creatorImage:
        "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=2564&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0003",
  ),
  Post(
    postId: "po-005",
    title: "Minimalist Business Card",
    description: "Simple yet effective business card designs. Feedback?",
    hashtags: "#businesscard #minimalist #design",
    images: [
      "https://i.pinimg.com/736x/f1/87/c9/f187c94e7bdd4b9d4c4c29fa1de5fb0a.jpg",
      "https://i.pinimg.com/736x/6d/75/ae/6d75ae3ab4f045c1e5ea9666a3b1d7af.jpg"
    ],
    questions: [
      OpenQuestion("What key info should always be on a business card?",
          QuestionType.open, RollOutType.like),
    ],
    creatorName: "Dante Moor",
    creatorImage:
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0001",
  ),
  Post(
    postId: "po-006",
    title: "Brand Identity Guidelines",
    description: "Working on a brand identity guide. What do you think?",
    hashtags: "#branding #guidelines #design",
    images: [
      "https://i.pinimg.com/736x/4f/20/e6/4f20e6adc6566a5826b803dafecc3b61.jpg",
      "https://i.pinimg.com/736x/0a/b1/ba/0ab1baaaff037eb6336b549f18316a15.jpg"
    ],
    questions: [
      ClosedQuestion(
          "How important is consistency in branding?",
          QuestionType.close,
          RollOutType.both,
          ["Very Important", "Not Important"]),
    ],
    creatorName: "Dante Moor",
    creatorImage:
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0001",
  ),
  Post(
    postId: "po-007",
    title: "Website Landing Page Concept",
    description: "A fresh and modern landing page layout concept.",
    hashtags: "#webdesign #landingpage #UIUX",
    images: [
      "https://i.pinimg.com/736x/2f/53/ca/2f53ca3d4b52e2428565f5fc4577b249.jpg",
      "https://i.pinimg.com/736x/24/2f/12/242f127228acf6c328218546c64bbb10.jpg",
    ],
    questions: [
      OpenQuestion("What should a perfect landing page include?",
          QuestionType.open, RollOutType.both),
    ],
    creatorName: "Dante Moor",
    creatorImage:
        "https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0001",
  ),
  Post(
    postId: "po-008",
    title: "Illustration for a Book Cover",
    description: "Concept art for a fantasy novel cover.",
    hashtags: "#illustration #bookcover #art",
    images: [
      "https://i.pinimg.com/736x/a5/cc/ae/a5ccae68771dd1ad54977d2f94c2e6d2.jpg",
      "https://i.pinimg.com/736x/c7/fb/31/c7fb31e30a4f8d067acde38ee51b8dbc.jpg"
    ],
    questions: [
      ClosedQuestion(
          "Which color scheme suits a fantasy book cover?",
          QuestionType.close,
          RollOutType.like,
          ["Dark & Mysterious", "Bright & Magical"]),
    ],
    creatorName: "Paul",
    creatorImage:
        "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0002",
  ),
  Post(
    postId: "po-009",
    title: "Social Media Post Design",
    description: "Creating engaging posts for Instagram & Twitter.",
    hashtags: "#socialmedia #marketing #design",
    images: [
      "https://i.pinimg.com/736x/54/60/71/5460718577e51bb4f6e9427bd108233a.jpg"
    ],
    questions: [
      OpenQuestion(
          "What makes a post go viral?", QuestionType.open, RollOutType.both),
    ],
    creatorName: "Paul",
    creatorImage:
        "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0002",
  ),
  Post(
    postId: "po-010",
    title: "Custom Icon Pack",
    description: "A set of hand-drawn icons for web and app UI.",
    hashtags: "#icons #design #UIUX",
    images: [
      "https://i.pinimg.com/736x/d6/5d/78/d65d784ba4170846c6567bc8237953cd.jpg",
      "https://i.pinimg.com/736x/bf/d7/67/bfd7676d69a814d43d563750fbb5f398.jpg"
    ],
    questions: [
      ClosedQuestion("Do you prefer line or filled icons?", QuestionType.close,
          RollOutType.both, ["Line Icons", "Filled Icons"]),
    ],
    creatorName: "Paul",
    creatorImage:
        "https://images.unsplash.com/photo-1608889175123-8ee362201f81?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    userId: "uid-0002",
  ),
];
