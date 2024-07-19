import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progressofttask/logic/cubit/posts/cubit.dart';
import 'package:progressofttask/logic/cubit/posts/states.dart';
import 'package:progressofttask/presentation/common/appbar/search.dart';
import 'package:progressofttask/presentation/screens/home/widgets/post.dart';
import 'package:progressofttask/presentation/screens/home/widgets/search_field.dart';
import 'package:progressofttask/utils/extensions/context.dart';

class HomeScreen extends StatelessWidget {
  static const routeIndex = 0;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.backgroundColor,
            appBar: SearchAppBar(
              searchField: SearchField(
                onChange: (q) async {
                  final postCubit = PostCubit.get(context);

                  await postCubit.searchPosts(q);
                },
              ),
            ),
            body: BlocBuilder<PostCubit, PostsStates>(
              builder: (context, state) {
                if (state is PostsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PostsEmptyState) {
                  return Center(
                    child: Text(
                      context.translate.noPostsFound,
                      style: context.titleLarge,
                    ),
                  );
                } else if (state is PostsLoadedState) {
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (_, i) {
                      return PostWidget(
                        post: state.posts[i],
                      );
                    },
                  );
                } else if (state is PostsErrorState) {
                  return Center(child: Text(state.message));
                }
                return Center(
                  child: Text(
                    context.translate.noPosts,
                    style: context.titleLarge,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
