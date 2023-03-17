part of 'img_bloc.dart';

class ImgState {
  String? imgPath;

  ImgState({required this.imgPath});
}

class ImgInitial extends ImgState {
  ImgInitial():super(imgPath: '');
}
