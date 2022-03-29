import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField {
  static Widget textFormWithNode({
    required BuildContext context,
    FocusNode? focusNode,
    //required String? onSaved(String? value),
    keyboardType = TextInputType.text,
    autofocse = false,
    TextEditingController? controller,
    required onChange(String value),
  }) {
    return new TextField(
      focusNode: focusNode,
      controller: controller,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.none,
      autocorrect: false,
      keyboardType: keyboardType,
      autofocus: autofocse,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      /*onSaved: (String? value) {
        onSaved(value);
      },*/
      onChanged: (String newVal) {
        onChange(newVal);
      },
    );
  }
}

///////////
///
