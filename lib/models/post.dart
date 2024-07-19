import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/post.freezed.dart';
part '../generated/models/post.g.dart';

@freezed
class AppPost with _$AppPost {
  const factory AppPost({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _AppPost;

  factory AppPost.fromJson(Map<String, dynamic> json) => _$AppPostFromJson(json);
}
