import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../common/app_colors.dart';
import '../common/app_fonts.dart';

class TextFieldComponent extends ConsumerStatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  final Function(String)? onSubmitted;

  final VoidCallback? onTap;
  final int? limitedLength;

  const TextFieldComponent(
      {super.key,
        this.hintText,
        this.controller,
        this.onChanged,
        this.limitedLength = 20,
        this.onSubmitted,
        this.onTap
      });

  @override
  ConsumerState<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends ConsumerState<TextFieldComponent> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    focusNode.unfocus();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: widget.controller,
      focusNode: focusNode,
      inputFormatters: [LengthLimitingTextInputFormatter(widget.limitedLength)],
      style: AppFonts.preBold(size: 14),
      onChanged: (text) {
        if (widget.onChanged != null) {
          widget.onChanged!(text);
        }
        //ref.read(textControllerProvider.notifier).setText(text);
      },
      onSubmitted: (text){
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(text);
        }
      },

      onTap: widget.onTap,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: AppColors.grey(2),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          hintText: widget.hintText,
          hintStyle: AppFonts.preSemiBold(
              size: 14, color: AppColors.grey(8))),
      cursorColor: AppColors.dark(8),
      onTapOutside: (_) {
        if (focusNode.hasFocus) {
          focusNode.unfocus();
        }
      },
    );
  }
}