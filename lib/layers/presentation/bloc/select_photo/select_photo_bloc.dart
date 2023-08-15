import 'dart:io';

import 'package:appnotion_photo_slide/layers/presentation/bloc/select_photo/select_photo_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

enum SelecPhotoEvent{showSelectPhotoPopUp,convertPhotosToVideo,noPhoto}

class SelectPhotoBloc extends Bloc<SelecPhotoEvent,SelectPhotoStates>{
   List<XFile> selectedImages=[];
  SelectPhotoBloc():super(const SelectPhotoStates.noPhoto()){
    on<SelecPhotoEvent>((event, emit) async {
     await mapEventToState(emit, event);
    });
  }




 Future mapEventToState(Emitter<SelectPhotoStates> emit,SelecPhotoEvent event) async {
    switch (event) {
      case SelecPhotoEvent.showSelectPhotoPopUp:
        final ImagePicker picker = ImagePicker();
        List<String> convertedImages = [];
        selectedImages = await picker.pickMultiImage(imageQuality: 20);
        selectedImages = selectedImages.map((e) {
          return e;
        }).toList();
        

        if(selectedImages.isNotEmpty){
          emit(SelectPhotoStates.photoSelectDone(selectedImages));
        }
        break;
      case SelecPhotoEvent.convertPhotosToVideo:
        await converPhotoToVideo(emit);
      break;
      case SelecPhotoEvent.noPhoto:
        emit(SelectPhotoStates.noPhoto());
        break;
    }
  }

 Future<void> converPhotoToVideo(Emitter<SelectPhotoStates> emit) async {
     Uuid uuid = Uuid();
   emit( const SelectPhotoStates.loading());
   final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

   final Directory appDir = await getApplicationDocumentsDirectory();
   var  _outputPath =await path.join(appDir.path, '${uuid.v1()}.mp4');
   List<String> _imagePaths = selectedImages.map((e) => e.path).toList();


   final String inputImages = _imagePaths.join('|');
   final String command = '-framerate 3/3 -i "concat:$inputImages" -c:v h264 $_outputPath';

  await _flutterFFmpeg.execute(command).then((value) {
     selectedImages.clear();
     if (value == 0) {
       Share.shareFiles([_outputPath]);
       emit(SelectPhotoStates.convertVideoFinish());
       print('Video kolajı başarıyla oluşturuldu: $_outputPath');
     } else {
       print('Video kolajı oluşturulurken bir hata oluştu');
     }
   });

 }



  }



