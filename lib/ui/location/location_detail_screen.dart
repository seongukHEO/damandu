import 'package:damandu/common/app_colors.dart';
import 'package:damandu/common/app_fonts.dart';
import 'package:damandu/common/app_images.dart';
import 'package:damandu/model/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LocationDetailScreen extends StatelessWidget {

  final LocationModel locationModel;
  const LocationDetailScreen({super.key, required this.locationModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: SvgPicture.asset(AppImages.arrowLeft)),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(40),
                        color: (locationModel.image == null || locationModel.image == '')
                            ? Colors.grey
                            : Colors.transparent,
                        image: (locationModel.image != null && locationModel.image != '')
                            ? DecorationImage(
                          image: NetworkImage(locationModel.image!),
                          fit: BoxFit.contain, // 🔥 원본 이미지 절대 잘림 없음
                        )
                            : null,
                      ),
                    )
                  ),
                  SizedBox(height: 30),
                  Center(child: Text('${locationModel.locationName}', style: AppFonts.preBold(size: 18, color: AppColors.limeGold(5)),)),
                  SizedBox(height: 20,),
                  Text('${locationModel.locationTitle}', style: AppFonts.preMedium(size: 18),),
                  SizedBox(height: 10,),
                  Text('${locationModel.locationContent}', style: AppFonts.preRegular(size: 18, color: Colors.grey.shade500),),
                  SizedBox(height: 50,),
                  Text('방문 시간 : ${formattedTime(locationModel.visitTime ?? DateTime.now())}', style: AppFonts.preBold(size: 18),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          )
      ),
    );
  }

  String formattedTime(DateTime dateTime){
    return DateFormat('MM월 dd일 HH시 mm분').format(dateTime);
  }
}
