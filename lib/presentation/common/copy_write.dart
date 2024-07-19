import 'package:flutter/material.dart';
import 'package:progressofttask/utils/extensions/context.dart';

class CopyWriteWidget extends StatelessWidget {
  const CopyWriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Text(
      "${context.translate.copyWrite} ${now.year} ${context.translate.allRights}",
      style: context.bodySmall,
    );
  }
}
