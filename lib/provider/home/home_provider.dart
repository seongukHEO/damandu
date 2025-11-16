import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final selectedIndexProvider =
StateNotifierProvider.autoDispose<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier(0);
});

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier(super.state);

  void setIndex(int index) {
    state = index;
  }
}

// 게시글에 단일 이미지 추가하기
class ImageNotifier extends StateNotifier<File?> {
  ImageNotifier() : super(null);

  // 단일 이미지 설정
  void setImage(File image) {
    state = image;
  }

  // 이미지 삭제
  void deleteImage() {
    state = null;
  }
}

final imageProvider = StateNotifierProvider<ImageNotifier, File?>((ref) {
  return ImageNotifier();
});

//게시물과 Q&A 제목을 적는 TextEditingController
class AddTitleTextFieldProvider extends StateNotifier<TextEditingController>{
  AddTitleTextFieldProvider() : super(TextEditingController());

  void setText(String newText){
    state.text = newText;
    state.selection = TextSelection.fromPosition(TextPosition(offset: state.text.length));
    state = TextEditingController.fromValue(state.value);
  }

  void clearText(){
    state.clear();
  }

  String getCurrentTitle(){
    return state.text;
  }
}

final addTitleTextFieldProvider = StateNotifierProvider<AddTitleTextFieldProvider, TextEditingController>((ref){
  return AddTitleTextFieldProvider();
});

//게시물과 Q&A 내용을 적는 TextEditingController
class AddLocationTextFieldProvider extends StateNotifier<TextEditingController>{
  AddLocationTextFieldProvider() : super(TextEditingController());

  void setText(String newText){
    state.text = newText;
    state.selection = TextSelection.fromPosition(TextPosition(offset: state.text.length));
    state = TextEditingController.fromValue(state.value);
  }

  void clearText(){
    state.clear();
  }

  String getCurrentText(){
    return state.text;
  }
}
final addLocationTextFieldProvider = StateNotifierProvider<AddLocationTextFieldProvider, TextEditingController>((ref){
  return AddLocationTextFieldProvider();
});



//게시물과 Q&A 내용을 적는 TextEditingController
class AddContentTextFieldProvider extends StateNotifier<TextEditingController>{
  AddContentTextFieldProvider() : super(TextEditingController());

  void setText(String newText){
    state.text = newText;
    state.selection = TextSelection.fromPosition(TextPosition(offset: state.text.length));
    state = TextEditingController.fromValue(state.value);
  }

  void clearText(){
    state.clear();
  }

  String getCurrentText(){
    return state.text;
  }
}
final addContentTextFieldProvider = StateNotifierProvider<AddContentTextFieldProvider, TextEditingController>((ref){
  return AddContentTextFieldProvider();
});


