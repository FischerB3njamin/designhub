class Profile {
  String name;
  String userId;
  List<String> posts;
  List<String> savedPosts;
  String backgroundImagePath;
  String avatarImagePath;
  String aboutMe;
  String interests;
  List<String> liked;
  List<String> sosPosts;
  List<String> following;

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
    List<String>? sosPosts,
    List<String>? following,
  })  : posts = posts ?? [],
        savedPosts = savedPosts ?? [],
        sosPosts = sosPosts ?? [],
        liked = liked ?? [],
        following = following ?? [];

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] ?? '',
      userId: map['userId'] ?? '',
      aboutMe: map['aboutMe'] ?? '',
      avatarImagePath: map['avatarImagePath'] ?? '',
      backgroundImagePath: map['backgroundImagePath'] ?? '',
      interests: map['interests'] ?? '',
      liked: List<String>.from(map['liked'] ?? []),
      posts: List<String>.from(map['posts'] ?? []),
      savedPosts: List<String>.from(map['savedPosts'] ?? []),
      sosPosts: List<String>.from(map['sosPosts'] ?? []),
      following: List<String>.from(map['following'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'aboutMe': aboutMe,
      'avatarImagePath': avatarImagePath,
      'backgroundImagePath': backgroundImagePath,
      'interests': interests,
      'liked': liked,
      'posts': posts,
      'savedPosts': savedPosts,
      'sosPosts': sosPosts,
      'following': following,
      'name_low': name.toLowerCase(),
    };
  }

  Profile copyWith({
    String? name,
    String? userId,
    String? aboutMe,
    String? avatarImagePath,
    String? backgroundImagePath,
    String? interests,
    List<String>? liked,
    List<String>? posts,
    List<String>? savedPosts,
    List<String>? sosPosts,
    List<String>? following,
  }) {
    return Profile(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      aboutMe: aboutMe ?? this.aboutMe,
      avatarImagePath: avatarImagePath ?? this.avatarImagePath,
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
      interests: interests ?? this.interests,
      liked: liked ?? this.liked,
      posts: posts ?? this.posts,
      savedPosts: savedPosts ?? this.savedPosts,
      sosPosts: sosPosts ?? this.sosPosts,
      following: following ?? this.following,
    );
  }
}
