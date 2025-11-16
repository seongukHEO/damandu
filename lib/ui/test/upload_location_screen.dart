import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/app_colors.dart';
import '../../common/app_fonts.dart';
import '../../common/app_images.dart';
import '../../component/image_processor.dart';
import '../../provider/home/home_provider.dart';

class UploadLocationScreen extends ConsumerStatefulWidget {
  const UploadLocationScreen({super.key});

  @override
  ConsumerState<UploadLocationScreen> createState() => _UploadLocationScreenState();
}

class _UploadLocationScreenState extends ConsumerState<UploadLocationScreen> {
  final FocusNode fileFocusNode = FocusNode();
  final FocusNode contentFocusNode = FocusNode();

  late final TextEditingController addTitleProvider;
  late final TextEditingController addContentProvider;

  late final TextEditingController addLocationProvider;

  XFile? image;

  @override
  void initState() {
    super.initState();
    addTitleProvider = TextEditingController();
    addContentProvider = TextEditingController();
    addLocationProvider = TextEditingController();
    fileFocusNode.addListener((){
      setState(() {

      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_){
      fileFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    fileFocusNode.removeListener((){});
    fileFocusNode.dispose();
    addTitleProvider.dispose();
    addContentProvider.dispose();
    addLocationProvider.dispose();
    super.dispose();
  }

  void goToAlbum(BuildContext context, WidgetRef ref) async {
    final XFile? pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);

      // ✅ 이미지 압축 및 회전 수정
      final compressedImage = await ImageProcessor.compressAndFixOrientation(
        imageFile: imageFile,
        targetWidth: 1024,
        quality: 80,
      );

      if (compressedImage != null) {
        // ✅ 단일 이미지 프로바이더 갱신
        ref.read(imageProvider.notifier).setImage(compressedImage);
      } else {
        // 압축 실패 시 알림
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("이미지 압축에 실패했습니다."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    final textTitle = ref.watch(addTitleTextFieldProvider);
    final textContent = ref.watch(addContentTextFieldProvider);


    final isTitleEmpty = textTitle.text.trim().isEmpty;
    final isContentEmpty = textContent.text.trim().isEmpty;

    final image = ref.watch(imageProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          ref.read(addTitleTextFieldProvider.notifier).clearText();
          ref.read(addContentTextFieldProvider.notifier).clearText();
          ref.read(imageProvider.notifier).deleteImage();
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        ref.read(addTitleTextFieldProvider.notifier).clearText();
                        ref.read(addContentTextFieldProvider.notifier).clearText();

                        ref.read(imageProvider.notifier).deleteImage();
                        context.pop();
                      },
                      child: SvgPicture.asset(AppImages.arrowLeft)
                  ),
                ],
              ),
              centerTitle: false,
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              autofocus: false,
                              focusNode: fileFocusNode,
                              controller: addLocationProvider,
                              style: AppFonts.preSemiBold(size: 14),
                              onChanged: (text){
                                ref.read(addLocationTextFieldProvider.notifier).setText(text);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  filled: false,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(width: 1, color: AppColors.dark(8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(width: 1, color: AppColors.grey(8))),
                                  hintText: "이름을 입력해주세요",
                                  hintStyle: AppFonts.preMedium(size: 14, color: AppColors.grey(8))
                              ),
                              cursorColor: AppColors.dark(8),
                              onTapOutside: (_){
                                if (fileFocusNode.hasFocus) {
                                  fileFocusNode.unfocus();
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            TextField(
                              autofocus: false,
                              controller: addTitleProvider,
                              style: AppFonts.preSemiBold(size: 14),
                              onChanged: (text){
                                ref.read(addTitleTextFieldProvider.notifier).setText(text);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  filled: false,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(width: 1, color: AppColors.dark(8)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(width: 1, color: AppColors.grey(8))),
                                  hintText: "타이틀을 입력해주세요",
                                  hintStyle: AppFonts.preMedium(size: 14, color: AppColors.grey(8))
                              ),
                              cursorColor: AppColors.dark(8),
                              onTapOutside: (_){
                                if (fileFocusNode.hasFocus) {
                                  fileFocusNode.unfocus();
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 300,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: contentFocusNode.hasFocus
                                      ? AppColors.dark(8)
                                      : AppColors.grey(8),
                                ),
                              ),
                              child: TextField(
                                autofocus: true,
                                focusNode: contentFocusNode,
                                controller: addContentProvider,
                                style: AppFonts.preSemiBold(size: 14),
                                onChanged: (text) {
                                  ref.read(addContentTextFieldProvider.notifier).setText(text);
                                },
                                decoration: InputDecoration(
                                  filled: false,
                                  border: InputBorder.none, // 밑줄 제거
                                  hintText: "내용을 작성해주세요😁",
                                  hintStyle: AppFonts.preSemiBold(
                                    size: 14,
                                    color: AppColors.grey(8),
                                  ),
                                ),
                                cursorColor: AppColors.dark(8),
                                onTapOutside: (_) {
                                  if (contentFocusNode.hasFocus) {
                                    contentFocusNode.unfocus();
                                  }
                                },
                                keyboardType: TextInputType.multiline, // 다중 입력 허용
                                textInputAction: TextInputAction.newline, // 엔터키로 줄바꿈
                                maxLines: null, // 줄바꿈 가능
                              ),
                            ),
                            SizedBox(height: 30),
                            Text("사진", style: AppFonts.preMedium(size: 18),),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    goToAlbum(context, ref); // 앨범으로 이동
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                                if (image != null) // 이미지가 있을 때만 표시
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.file(
                                                    image,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    ref.read(imageProvider.notifier).deleteImage(); // 이미지 삭제
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40),
                                                      color: Colors.white,
                                                    ),
                                                    child: Icon(Icons.clear),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
                    child: GestureDetector(
                      onTap: ()async{

                      },
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                            color: AppColors.limeGold(5),
                            borderRadius: BorderRadius.circular(12)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("등록하기",
                              style: AppFonts.preBold(
                                  size: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future _addQuestion(WidgetRef ref, BuildContext context) async {
  //   final loading = ref.watch(isLoadingProvider.notifier);
  //   final userModel = ref.read(getUserInfoFutureProvider);
  //   final questionTitle = ref.watch(addTitleTextFieldProvider.notifier).getCurrentTitle();
  //   final questionContent = ref.watch(addContentTextFieldProvider.notifier).getCurrentText();
  //   final questionTopic = ref.watch(selectedTopicProvider.notifier).state;
  //   final image = ref.watch(imageProvider);
  //
  //
  //   if (questionTitle.trim().isEmpty || questionContent.trim().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("제목과 내용을 입력해주세요.")),
  //     );
  //     return;
  //   }
  //
  //   loading.state = true;
  //   try {
  //     // 1) 질문 생성(이미지 없이)
  //     final questionModel = QuestionModel(
  //       contents: questionContent,
  //       questionTopic: questionTopic ?? '',
  //       questionImg: null,
  //       createQuestion: DateTime.now(),
  //       title: questionTitle,
  //       questionClickCount: 0,
  //       questionUid: '',              // 서버에서 생성 후 교체
  //       questionFavorite: 0,
  //       userUid: userModel.value?.uid ?? '',
  //       user_id: userModel.value?.id,
  //     );
  //
  //     final newId = await ref.read(questionDataSourceProvider).addQuestionToServer(questionModel);
  //     if (newId == null) throw Exception('질문 생성 실패: ID 없음');
  //
  //     // 2) 이미지 있으면 업로드
  //     String? imageUrl;
  //     if (image != null) {
  //       final path = await ref.read(questionDataSourceProvider).uploadQuestionImg(image, newId.toString());
  //       final uri = Uri.parse(path);
  //       final cleanPath = uri.path.contains('/founderimages/')
  //           ? uri.path.split('/founderimages/').last
  //           : uri.path;
  //       imageUrl = 'http://20.39.192.136/api/imageDown/$cleanPath';
  //     }
  //
  //     final updated = questionModel.copyWith(
  //       id: newId, // ✅ 서버에서 받은 id를 직접 넣기
  //       questionImg: imageUrl,
  //     );
  //     await ref.read(questionDataSourceProvider).updateQuestionById(newId, updated);
  //
  //     loading.state = false;
  //     addQuestionDialog(context, updated);
  //   } catch (e) {
  //     debugPrint('❌ 질문 저장 중 오류: $e');
  //     loading.state = false;
  //   }
  // }
}
