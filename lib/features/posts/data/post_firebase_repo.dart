import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/data/post_repo.dart';

class PostFirebaseRepo extends PostRepo {
  final CollectionReference postsRef =
      FirebaseFirestore.instance.collection('posts');

  @override
  Future<List<Post>> getPostsByUsers(
    List<String> userIds,
    bool isSos, {
    int page = 0,
    int limit = 10,
  }) async {
    try {
      return (await postsRef
              .where('userId', whereIn: userIds)
              .where('isSos', isEqualTo: isSos)
              .where('isActive', isEqualTo: true)
              .limit(limit)
              .get())
          .docs
          .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Future<Post> getPostById(String postId) async {
    final doc = await postsRef.doc(postId).get();
    if (!doc.exists) throw Exception('Post not found');

    final post = Post.fromMap(doc.data() as Map<String, dynamic>);
    return post;
  }

  @override
  Future<List<Post>> getPosts(String userId, bool isSos,
      {int page = 0, int limit = 10}) async {
    try {
      var snapshot = isSos
          ? await postsRef
              .where('userId', isNotEqualTo: userId)
              .where('isSos', isEqualTo: isSos)
              .where('isActive', isEqualTo: true)
              .orderBy('postId')
              .limit(limit)
              .get()
          : await postsRef
              .where('userId', isNotEqualTo: userId)
              .where('isSos', isEqualTo: isSos)
              .orderBy('postId')
              .limit(limit)
              .get();

      final posts = snapshot.docs
          .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return posts;
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Future<List<Post>> getPostsByUserId(String userId, bool isSos,
      {int page = 0, int limit = 30}) async {
    final snapshot = await postsRef
        .where('userId', isEqualTo: userId)
        .where('isSos', isEqualTo: isSos)
        .orderBy('postId')
        .limit(limit)
        .get();

    final posts = snapshot.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return posts;
  }

  @override
  Future<String> createPost(Post post) async {
    if (post.postId.isEmpty) {
      post.postId = await createPostId();
    }

    await postsRef.doc(post.postId).set(post.toMap());

    return post.postId;
  }

  @override
  Future<String> createPostId() async {
    String id = postsRef.doc().id;
    return id;
  }

  @override
  Future<List<Post>> getPostsById(Set<String> postIds) async {
    try {
      if (postIds.isEmpty) return [];
      final snapshots = await Future.wait(
        postIds.map((id) => postsRef.doc(id).get()),
      );

      final posts = snapshots
          .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return posts;
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Future<void> deletePost(String postId) async {
    await postsRef.doc(postId).update({"isActive": false});
  }

  Future<void> update() async {
    final result = await postsRef.get();
    final posts =
        result.docs.map((e) => Post.fromMap(e.data() as Map<String, dynamic>));
    for (final post in posts) {
      postsRef.doc(post.postId).update(post.toMap());
    }
  }
}
