import 'package:damandu/common/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_fonts.dart';


class FixedMarkerBottomSheet extends ConsumerStatefulWidget {
  final String fixedName;
  final String imageUrl;
  final String content;

  const FixedMarkerBottomSheet({
    super.key,
    required this.fixedName,
    required this.imageUrl,
    required this.content
  });

  @override
  ConsumerState<FixedMarkerBottomSheet> createState() => _FixedMarkerBottomSheetState();
}

class _FixedMarkerBottomSheetState extends ConsumerState<FixedMarkerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.63,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(widget.imageUrl, fit: BoxFit.cover,),
              ),
              SizedBox(width: 15),
              Text(widget.fixedName, style: AppFonts.preBold(size: 18)),
            ],
          ),
          const SizedBox(height: 20),
          Text(widget.content, style: AppFonts.preMedium(size: 14))
        ],
      ),
    );
  }
}
