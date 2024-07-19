import 'package:progressofttask/models/post.dart';

abstract class PostsStates {}

class PostsInitState extends PostsStates {}

class PostsLoadingState extends PostsStates {}

class PostsErrorState extends PostsStates {
  final String message;

  PostsErrorState(this.message);
}

class PostsLoadedState extends PostsStates {
  final List<AppPost> posts;

  PostsLoadedState(this.posts);
}

class PostsEmptyState extends PostsStates {}
