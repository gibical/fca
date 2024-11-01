import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';

class DeleteAccountWidget extends StatefulWidget {
  const DeleteAccountWidget({super.key});

  @override
  State<DeleteAccountWidget> createState() => _DeleteAccountWidgetState();
}

class _DeleteAccountWidgetState extends State<DeleteAccountWidget> implements RequestInterface{
  
  late ApiRequster apiRequster;
  
  
  var isloading = false.obs;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiRequster = ApiRequster(this,develperModel: true);
    
  }
  
  @override
  Widget build(BuildContext context) {
    return      Container(
      width: 100.w,
      padding: EdgeInsets.all(4.w
      ),
      height: 25.h,
      decoration: BoxDecoration(
          color: "3b3a5a".toColor(),
          border: Border(
            left: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 0.4),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("delete_1".tr,style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 3.h,),
          Container(
            width: 100.w,
            height: 6.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(10)
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)

              ),
              padding: EdgeInsets.zero,
              onPressed: (){

                sumitDeleteRequest();
              },
              child: Obx(()=>Center(
                child:isloading.value?CircularProgressIndicator(): Text("delete_2".tr,style: TextStyle(
                    color:Colors.red,fontWeight: FontWeight.bold
                ),),
              )),
            ),
          ),
          SizedBox(height: 1.5.h,),
          Container(
            width: 100.w,
            height: 6.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10)
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)

              ),
              padding: EdgeInsets.zero,
              onPressed: (){

                Get.back();
              },
              child: Center(
                child: Text("delete_3".tr,style: TextStyle(
                    color:Colors.green,fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
  }
  void _logOut() async{

    var box  = GetStorage();
    box.write("islogin", false);
    Get.offAllNamed(PageRoutes.SPLASH,);
  }
  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    isloading(false);
    Constant.showMessege("Account Deleted");
    _logOut();

  }
  sumitDeleteRequest(){
    isloading(true);
    apiRequster.request("account", ApiRequster.MHETOD_DELETE, 1);
  }
}
