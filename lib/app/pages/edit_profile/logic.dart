import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';

import 'state.dart';

class EditProfileLogic extends GetxController implements RequestInterface {
  final EditProfileState state = EditProfileState();


  TextEditingController assetsEditingController = TextEditingController();
  TextEditingController assetsDescreptionEditingController = TextEditingController();
  TextEditingController isEditEditingController = TextEditingController();
  TextEditingController planController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController imdbScooreController = TextEditingController();
  TextEditingController imdbYeaerController = TextEditingController();

  DetailController detailController;
  EditProfileLogic(this.detailController);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    assetsEditingController.text = detailController.detailss!['name'];
    assetsDescreptionEditingController.text = detailController.detailss!['description']??"";
    isEditEditingController.text = detailController.detailss!['forkability_status'].toString().contains("1")?"Yes":"No";
    planController.text = _getDropDownByPlan(detailController.detailss!['plan'].toString());

  }
  _getPlanByDropDown() {
    switch (planController.text) {
      case "Free":
        return "1";
      case "Ownership":
        return "2";
      case "Subscription":
        return "3";
    }
  }
  _getDropDownByPlan(String string ) {
    switch (string) {
      case "1":
        return "Free";
      case "2":
        return "Ownership";
      case "3":
        return "Subscription";
    }
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
