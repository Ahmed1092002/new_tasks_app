import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String?buttonName;
  final void Function()? onPressed;
 const  CustomButton({
    super.key,
    this.buttonName,
     this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(400, 50),
          backgroundColor: Color(0xFF9B12AC),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        buttonName!,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
