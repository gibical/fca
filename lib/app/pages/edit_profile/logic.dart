import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';

import 'state.dart';

class EditProfileLogic extends GetxController implements RequestInterface {
  final EditProfileState state = EditProfileState();


  TextEditingController assetsEditingController = TextEditingController();
  TextEditingController assetsDescreptionEditingController = TextEditingController();
  DetailController detailController;
  EditProfileLogic(this.detailController);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    assetsEditingController.text = detailController.detailss!['name'];
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
  }
}
