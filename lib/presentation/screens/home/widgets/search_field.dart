import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressofttask/logic/cubit/posts/cubit.dart';
import 'package:progressofttask/logic/cubit/posts/states.dart';
import 'package:progressofttask/presentation/common/primary_field.dart';
import 'package:progressofttask/utils/extensions/context.dart';
import 'package:progressofttask/utils/theme/images.dart';

class SearchField extends StatefulHookWidget {
  const SearchField({
    super.key,
    required this.onChange,
  });
  static String tag = 'search';
  final Future<void> Function(String) onChange;

  @override
  State<StatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();

    return Center(
      child: Hero(
        tag: SearchField.tag,
        child: SizedBox(
          height: 54,
          child: Material(
            color: Colors.transparent,
            child: PrimaryTextField(
              controller: searchTextController,
              onChanged: (value) async {
                await widget.onChange(value);
                if (mounted) setState(() {});
              },
              autoFocus: true,
              suffixIcon: SizedBox(
                width: 52,
                height: 52,
                child: BlocBuilder<PostCubit, PostsStates>(
                  builder: (context, state) {
                    if (state is PostsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Visibility(
                      visible: searchTextController.text.isNotEmpty,
                      child: IconButton(
                        onPressed: () => setState(() {
                          PostCubit.get(context).clearSerch();
                          searchTextController.text = '';
                        }),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    );
                  },
                ),
              ),
              prefixIcon: SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.search,
                  ),
                ),
              ),
              hintText: context.translate.search,
            ),
          ),
        ),
      ),
    );
  }
}
