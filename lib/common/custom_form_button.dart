import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final double textSize;
  final double inputSize; // New attribute for input tab size
  final void Function()? onPressed;

  const CustomFormButton({
    Key? key,
    required this.innerText,
    required this.textSize,
    required this.inputSize,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * inputSize, 
      height: 42,// Use inputSize to set the width
      decoration: BoxDecoration(
        color: const Color(0xff233743),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: TextStyle(color: Colors.white, fontSize: textSize),
        ),
      ),
    );
  }
}
