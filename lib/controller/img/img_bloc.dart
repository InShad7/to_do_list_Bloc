import 'package:bloc/bloc.dart';
import 'package:just_do_it/screens/addEvent.dart';
import 'package:meta/meta.dart';

part 'img_event.dart';
part 'img_state.dart';

class ImgBloc extends Bloc<ImgEvent, ImgState> {
  ImgBloc() : super(ImgInitial()) {
    on<AddImage>((event, emit) {
      return emit(ImgState(imgPath: PickedFile!.path));
    });


     on<InitialImg>((event, emit) {
      return emit(ImgState(imgPath: ''));
    });
  }
}
