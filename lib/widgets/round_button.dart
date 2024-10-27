import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final VoidCallback? onTap;
  final bool loading; // Mark this field as final

  RoundButton({
    this.onTap,
    this.loading = false,
    required String title,
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: widget.loading
                ? CircularProgressIndicator()
                : Text(
                    '', // You can leave this empty or add a default text here
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
