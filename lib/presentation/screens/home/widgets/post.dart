import 'package:flutter/material.dart';
import 'package:progressofttask/models/post.dart';
import 'package:progressofttask/presentation/screens/home/widgets/post_data.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/colors.dart';

class PostWidget extends StatelessWidget {
  final AppPost post;
  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(
      Radius.circular(
        8,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        color: context.backgroundColor,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: () {
            context.navigator.push(
              MaterialPageRoute(
                builder: (_) => PostInside(
                  title: post.title,
                  body: post.body,
                ),
              ),
            );
          },
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.muted,
              ),
              borderRadius: radius,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  textAlign: TextAlign.start,
                  style: context.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  post.body,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
