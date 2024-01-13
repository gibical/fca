

import 'package:get/get.dart';

class SearchLogic extends GetxController{
  bool isAdvancedSearchVisible = false;


  showAdvanceTextField(){
    isAdvancedSearchVisible =! isAdvancedSearchVisible;
    update();
  }
}