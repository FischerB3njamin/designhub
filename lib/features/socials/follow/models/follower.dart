class Follower {
  final String profilId;
  final List<String> followMe;

  Follower({
    required this.profilId,
    required this.followMe,
  });

  factory Follower.fromMap(Map<String, dynamic> map) {
    final followRaw = map['followMe'];
    List<String> followList = [];

    if (followRaw is List) {
      followList = followRaw.cast<String>();
    }

    return Follower(
      profilId: map['profilId'] ?? '',
      followMe: followList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profilId': profilId,
      'followMe': followMe,
    };
  }

  Follower copyWith({
    String? profilId,
    List<String>? followMe,
  }) {
    return Follower(
      profilId: profilId ?? this.profilId,
      followMe: followMe ?? this.followMe,
    );
  }
}
