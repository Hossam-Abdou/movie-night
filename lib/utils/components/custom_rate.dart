import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRate extends StatelessWidget {
final String? rate;

const CustomRate({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageIcon(
          AssetImage('assets/images/star.png'),
          color: Color(0xffFFBB3B),
        ),
        // Icon(Icons.star,color: Colors.yellow,),
        Text(
          rate??'',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
