import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_strings/app_strings.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback? onTap;


const DeleteDialog({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      backgroundColor:
      Colors.white54.withOpacity(0.4),
      title: Center(
        child: Text(
          'Are you sure?',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed:onTap,
          child: Text(
            AppStrings.delete,
            style: GoogleFonts.poppins(
              color:Colors.redAccent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppStrings.dontDelete,
            style: GoogleFonts.poppins(
              color: AppColors.yellowColor,
              fontWeight: FontWeight.w800,

            ),
          ),
        ),
      ],
    );
  }
}
