import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_do_it/controller/img/img_bloc.dart';
import 'package:just_do_it/utilities/colors.dart';

XFile? pickedFile;

class AddImageEvent extends StatelessWidget {
  String img;

   AddImageEvent({super.key,required this.img});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   return BlocProvider.of<ImgBloc>(context).add(InitialImg());
    // });
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<ImgBloc, ImgState>(
          builder: (context, state) {
            return Stack(
              children: [
                InkWell(
                  onTap: () => pickImage(context),
                  child: Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ThemeGrey(),
                      image: DecorationImage(
                        image: state.imgPath == ''
                            ? AssetImage('assets/images/bg.jpg')
                                as ImageProvider
                            : FileImage(File(state.imgPath!)),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Icon(
                    Icons.photo_library_rounded,
                    size: 30,
                    color: Grey(),
                  ),

                  // pickImage(),
                )
              ],
            );
          },
        ));
  }

  Future<void> pickImage(context) async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      BlocProvider.of<ImgBloc>(context).add(AddImage());
      // setState(() {
      //   imagePath = PickedFile.path;
      // });
    }
  }
}
