
import 'package:get/get.dart';


class EditDataModel {
  final String name;

  EditDataModel(this.name);
}

class MediaSuitController extends GetxController {
  var editTextDataList = <EditDataModel>[].obs;
  var editImageDataList = <EditDataModel>[].obs;
  var editVideoDataList = <EditDataModel>[].obs;
  var editAudioDataList = <EditDataModel>[].obs;


  void setDataEditText(String name) {
    editTextDataList.add(EditDataModel(name));

  }

  void setDataEditImage(String name) {
    editImageDataList.add(EditDataModel(name));

  }

  void setDataEditVideo(String name) {
    editVideoDataList.add(EditDataModel(name));

  }
  void setDataEditAudio(String name) {
    editAudioDataList.add(EditDataModel(name));

  }
}
