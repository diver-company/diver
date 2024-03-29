import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatefulWidget {
  PrimaryButton(
      {super.key,
      required this.text,
      this.icon,
      this.disabled = false,
      required this.onTap});

  bool disabled;
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.disabled
          ? Colors.grey
          : Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(6.0),
      child: widget.disabled
          ? AbsorbPointer(
              child: _buttonState(),
            )
          : InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(6.0),
              child: GestureDetector(child: _buttonState()),
            ),
    );
  }

  Widget _buttonState() {
    return Container(
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
            widget.text,
            style: GoogleFonts.inter(
                textStyle: const TextStyle(color: Colors.white),
                fontWeight: FontWeight.w500,
                fontSize: 20.0),
          ),
          const SizedBox(width: 8),
          if (widget.icon != null)
            Icon(
              widget.icon,
              size: 20.0,
              color: Colors.white,
            )
        ],
      ),
    );
  }
}
