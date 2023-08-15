import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

part 'select_photo_states.freezed.dart';


@freezed
sealed class SelectPhotoStates with _$SelectPhotoStates {
  const factory SelectPhotoStates.loading() = Loading;
  const factory SelectPhotoStates.error([String? message]) = Error;
  const factory SelectPhotoStates.noPhoto() = NoPhoto;
  const factory SelectPhotoStates.showPhotoSelectPopUP() = SelectPhoto;
  const factory SelectPhotoStates.convertVideoFinish() = ConvertVideo;
  const factory SelectPhotoStates.photoSelectDone(List<XFile> images) = PhotoSelectDone;
}