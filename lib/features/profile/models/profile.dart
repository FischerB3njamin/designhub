class Profile {
  String name;
  String userId;

  List<String> posts = [];
  List<String> savedPosts = [];
  // images
  String backgroundImagePath = "";
  String avatarImagePath = "";

  String aboutMe = "";
  String interests = "";

  List<String>? liked = [];

  Profile({
    required this.name,
    required this.userId,
    this.aboutMe = "",
    this.avatarImagePath = "",
    this.backgroundImagePath = "",
    this.interests = "",
    List<String>? liked,
    List<String>? posts,
    List<String>? savedPosts,
  })  : posts = posts ?? [],
        savedPosts = savedPosts ?? [],
        liked = liked ?? [];
}
