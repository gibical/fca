import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class CommentScreen extends StatefulWidget {
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final DetailController commentController = Get.arguments['logic'];

  @override
  void initState() {
    super.initState();
    commentController.fetchMediaComments();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff55647d),
        toolbarHeight: 15.h,
        flexibleSpace: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 7.w ,  ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 1.w , vertical: 2.h),
                child: Row(
                  children: [
                    Text('details_1'.tr , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                      color: Colors.white,

                    ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Text('details_2'.tr , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                        color: Colors.grey,

                      ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Row(

                children: [
                  CircleAvatar(
                    radius: 18.5,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 5.h,
                      child: TextField(
                        controller: commentController.commentTextController,
                        onSubmitted: (comment) {
                          commentController.postComment();
                          commentController.fetchMediaComments();
                          commentController.commentTextController.text ='';
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black54,
                            hintText: 'details_3'.tr,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff55647d),
      body: Obx(() {
        if (commentController.isLoadingComment.value) {
          return Center(child: CircularProgressIndicator());
        } else if (commentController.commentsData == null ||
            commentController.commentsData!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('details_4'.tr),
                ElevatedButton(
                  onPressed: () {
                    commentController.fetchMediaComments();
                  },
                  child: Text('details_5'.tr),
                ),
              ],
            ),
          );
        } else {
          return CustomScrollView(
            slivers: [

              SliverList.builder(
                  itemCount: commentController.commentsData!['data'].length,
                  itemBuilder: (context , index){
                    print('_CommentScreenState.build = ${commentController.commentsData!}');
                    final comment =
                commentController.commentsData!['data'][index];
                final bodyText = comment['body'].toString();
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 7.5.w , vertical: 1.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w , vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.011),
                      borderRadius: BorderRadius.circular(15.sp),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.3) , width: 0.8),
                        left: BorderSide(color: Colors.grey.withOpacity(0.3) , width: 0.8),
                        right: BorderSide(color: Colors.grey.withOpacity(0.3) , width: 0.4),
                        top: BorderSide(color: Colors.grey.withOpacity(0.3) , width: 0.4)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(

                              child: CircleAvatar(
                                backgroundColor: AppColor.blueDarkColor,
                                backgroundImage:
                                NetworkImage(comment?['user']['image_url']),
                              ),
                              width: 7.w,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                           if(comment?['user']!=null) Text(comment?['user']['username'] , style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(

                            ),
                            ),
                            Spacer(),


                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 1.2.h , horizontal: 1.w),
                          child: Text(bodyText),
                        ),
                      ],
                    ),
                  ),
                );
              })
            ],
          );


        }
      }),
    );
  }
}
