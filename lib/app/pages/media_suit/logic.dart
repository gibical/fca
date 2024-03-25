
import 'package:get/get.dart';


class EditDataModel {
  final String name;
  final String? urlVideo;

  EditDataModel(this.name, this.urlVideo);
}

class MediaSuitController extends GetxController {
  var editTextDataList = <EditDataModel>[].obs;
  var editImageDataList = <EditDataModel>[].obs;
  var editVideoDataList = <EditDataModel>[].obs;
  var editAudioDataList = <EditDataModel>[].obs;


  void setDataEditText(String name) {
    editTextDataList.add(EditDataModel(name , ''));

  }

  void setDataEditImage(String name) {
    editImageDataList.add(EditDataModel(name , ''));

  }

  void setDataEditVideo(String name , String videoUrl) {
    editVideoDataList.add(EditDataModel(name , videoUrl ));

  }
  void setDataEditAudio(String name) {
    editAudioDataList.add(EditDataModel(name ,''));

  }
}
