import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartAppBar extends AppBar {
  CartAppBar({Key? key}) : super(key: key);
  @override
  Widget? get title => Text(
        'Cart',
        style: GoogleFonts.cairo(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
