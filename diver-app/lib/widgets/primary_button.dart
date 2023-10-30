import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.text, this.icon, required this.onTap});

  final String text;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF3E8989),
      borderRadius: BorderRadius.circular(6.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.0),
        child: GestureDetector(
          child: Container(
            width: double.infinity,
            height: 56.0,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(18, 18, 18, 18),
                    blurRadius: 4.0,
                    offset: Offset(0, 4.0))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(color: Colors.white),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0),
                ),
                const SizedBox(width: 8),
                Icon(
                  icon,
                  size: 20.0,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
