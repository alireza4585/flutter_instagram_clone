import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/data/firebase_service/firestor.dart';
import 'package:flutter_instagram_clone/util/image_cached.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Comment extends StatefulWidget {
  String type;
  String uid;
  Comment(this.type, this.uid, {super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final comment = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool islodaing = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.r),
        topRight: Radius.circular(25.r),
      ),
      child: Container(
        color: Colors.white,
        height: 200.h,
        child: Stack(
          children: [
            Positioned(
              top: 8.h,
              left: 140.w,
              child: Container(
                width: 100.w,
                height: 3.h,
                color: Colors.black,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(widget.type)
                  .doc(widget.uid)
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return comment_item(snapshot.data!.docs[index].data());
                    },
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 60.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 45.h,
                      width: 260.w,
                      child: TextField(
                        controller: comment,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          islodaing = true;
                        });
                        if (comment.text.isNotEmpty) {
                          Firebase_Firestor().Comments(
                            comment: comment.text,
                            type: widget.type,
                            uidd: widget.uid,
                          );
                        }
                        setState(() {
                          islodaing = false;
                          comment.clear();
                        });
                      },
                      child: islodaing
                          ? SizedBox(
                              width: 10.w,
                              height: 10.h,
                              child: const CircularProgressIndicator(),
                            )
                          : const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comment_item(final snapshot) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          height: 35.h,
          width: 35.w,
          child: CachedImage(
            snapshot['profileImage'],
          ),
        ),
      ),
      title: Text(
        snapshot['username'],
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        snapshot['comment'],
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
