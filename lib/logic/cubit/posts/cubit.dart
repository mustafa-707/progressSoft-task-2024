import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/logic/cubit/posts/states.dart';
import 'package:progressofttask/models/post.dart';
import 'package:http/http.dart' as http;

class PostCubit extends Cubit<PostsStates> {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  PostCubit() : super(PostsInitState()) {
    fetchPosts();
  }
  List<AppPost> posts = [];
  static PostCubit get(context) => BlocProvider.of<PostCubit>(context);

  Future<void> fetchPosts() async {
    emit(PostsLoadingState());
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        posts = data.map((json) => AppPost.fromJson(json)).toList();
        if (posts.isEmpty) {
          emit(PostsEmptyState());
        } else {
          emit(PostsLoadedState(posts));
        }
      } else {
        emit(PostsErrorState('Failed to load posts'));
      }
    } catch (e) {
      emit(PostsErrorState('Failed to load posts'));
    }
  }

  Future<void> searchPosts(String query) async {
    emit(PostsLoadingState());

    final filteredPosts = posts.where((post) {
      final titleMatch = post.title.toLowerCase().contains(query.toLowerCase());
      final bodyMatch = post.body.toLowerCase().contains(query.toLowerCase());
      return titleMatch || bodyMatch;
    }).toList();

    if (filteredPosts.isEmpty) {
      emit(PostsEmptyState());
    } else {
      emit(PostsLoadedState(filteredPosts));
    }
  }

  Future<void> clearSerch() async {
    emit(PostsLoadedState(posts));
  }
}
