import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/profile/data/profile.mock.dart';

final List<Chat> mockChats = [
  for (int i = 1; i <= profiles.length - 2; i++)
    Chat(
      chatItems: [
        for (int j = 1; j <= 10; j++)
          ChatItem(
            text: [
              "Hey, what do you think of this new color palette?",
              "I'm struggling with typography choices, any suggestions?",
              "Does this layout feel balanced to you?",
              "Looking for feedback on my latest UI concept!",
              "Any thoughts on this logo redesign?",
              "Trying to decide between these two font pairings. Help!",
              "What are your favorite design tools right now?",
              "Does this animation feel smooth enough?",
              "Critique my new website mockup!",
              "How do you handle creative blocks?"
            ][j % 10],
            date: "11.12",
            userId: j % 2 == 0 ? profiles[0].userId : profiles[i].userId,
          ),
      ],
      participants: [profiles[0].userId, profiles[i].userId],
    ),
];
