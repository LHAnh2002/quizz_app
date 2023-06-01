import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w, bottom: 16.h),
      child: const Center(
        child: Text('Xinchao'),
      ),
    );
  }
}
