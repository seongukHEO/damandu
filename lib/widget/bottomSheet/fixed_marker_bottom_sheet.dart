import 'package:damandu/common/app_images.dart';
import 'package:damandu/model/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_fonts.dart';


class FixedMarkerBottomSheet extends ConsumerStatefulWidget {
  final LocationModel locationModel;

  const FixedMarkerBottomSheet({
    super.key,
    required this.locationModel,
  });

  @override
  ConsumerState<FixedMarkerBottomSheet> createState() =>
      _FixedMarkerBottomSheetState();
}

class _FixedMarkerBottomSheetState
    extends ConsumerState<FixedMarkerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        color: Colors.white,
      ),

      /// 🔥 내부 스크롤 가능하도록 만들기
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(40),
                    color: (widget.locationModel.image == null ||
                        widget.locationModel.image == '')
                        ? Colors.grey
                        : Colors.transparent,
                    image: (widget.locationModel.image != null &&
                        widget.locationModel.image != '')
                        ? DecorationImage(
                      image:
                      NetworkImage(widget.locationModel.image!),
                      fit: BoxFit.contain,
                    )
                        : null,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    widget.locationModel.locationName,
                    style: AppFonts.preBold(
                      size: 18,
                      color: AppColors.limeGold(5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.locationModel.locationTitle,
              style: AppFonts.preSemiBold(size: 14),
            ),
            const SizedBox(height: 20),
            Text(
              widget.locationModel.locationContent,
              style: AppFonts.preMedium(size: 14),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

