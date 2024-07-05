import 'package:flutter/material.dart';
import 'package:hey_app/appColors.dart';

class UserTile extends StatelessWidget {
  final String text ;
  final void Function()? onTap;


  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(height: 69,
        decoration:BoxDecoration(
          color: AppColors.sender,
          borderRadius: BorderRadius.circular(15)
        ),
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),

        child: Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              child: Icon(Icons.person,color: AppColors.appbar),radius: 25,

            ),
            SizedBox(width: 15),

            Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.5,color: AppColors.appbar),)
          ],
        ),

      ),
    );
  }
}
