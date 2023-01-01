import 'package:flutter/material.dart';

myFormField({
  TextEditingController? controller ,
  TextInputType ? type ,
  String ? label ,
  String ? hint ,
  int ? minLines ,
  int ? maxLength ,
  IconData? prefixIcon,
  IconData ? suffixIcon,
  bool  obscureText = false ,
  bool  isClickable = true ,
  bool expands = false,
  bool isVaildator = false,
  Function? suffixPressed,
  EdgeInsetsGeometry ? FormFieldHeight,

}){
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: obscureText,
    enabled: isClickable,
    minLines: minLines,
    maxLength: maxLength,
    expands: expands,
    validator: (value) {
      if (isVaildator == true && value!.isEmpty && value.trim().length == 0){
        return '$label must not be empty';
      }
    },
    decoration: InputDecoration(
      contentPadding: FormFieldHeight,
      hintText: hint,
      prefixIcon: Icon(prefixIcon),
      prefixIconColor: Colors.white,
      suffixIcon:suffixIcon != null
          ? IconButton(
        onPressed: () {
          suffixPressed!();
        },
        icon: Icon(suffixIcon),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}