import 'package:flutter/material.dart';
import 'package:progressofttask/presentation/common/appbar/sub_screen.dart';
import 'package:progressofttask/utils/extensions/context.dart';

class PostInside extends StatelessWidget {
  final String title;
  final String body;

  const PostInside({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: SubScreenAppBar(
          title: title,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    body,
                    style: context.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
