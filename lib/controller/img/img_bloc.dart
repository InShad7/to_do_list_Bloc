import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:just_do_it/screens/editEvent.dart';
import 'package:just_do_it/widgets/addImage.dart';

part 'img_event.dart';
part 'img_state.dart';

class ImgBloc extends Bloc<ImgEvent, ImgState> {
  ImgBloc() : super(ImgInitial()) {
    on<AddImage>((event, emit) {
      return emit(ImgState(imgPath: pickedFile!.path));
    });

    on<InitialImg>((event, emit) {
      return emit(ImgState(imgPath: ''));
    });

    on<EditImg>((event, emit) {
      return emit(ImgState(imgPath: editImg));
    });
    log(editImg.toString());
  }
}
