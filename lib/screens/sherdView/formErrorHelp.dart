class FormValidator {
  // Form Error
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final String emailNullError = "Please Enter your email";

  final String invalidEmailError = "Please Enter Valid Email";
  final String passNullError = "Please Enter your password";
  final String shortPassError = "Password is too short";
  final String matchPassError = "Passwords don't match";

  factory FormValidator() => new FormValidator._();

  FormValidator._();

  String? validateisEmpty(String value, String field) {
    /* String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    */
    if (value.isEmpty) {
      return 'الرجاء ادخال  $field  ';
    }
    /*else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }*/
    else {
      return null;
    }
  }

  String? validateisEmptyLoginUser(String? value) {
    /* String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    */
    if (value!.isEmpty == true) {
      return 'الرجاء ادخال اسم المستخدم  ';
    }
    /*else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }*/
    else {
      return null;
    }
  }

  String? validateisEmptyLoginPass(String? value) {
    /* String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    */
    if (value!.isEmpty) {
      return 'الرجاء ادخال اسم كلمة السر  ';
    }
    /*else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }*/
    else {
      return null;
    }
  }

  String? validateisEmail(String value, String filed) {
    String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    /* if (value.isEmpty) {
      return 'الرجاء ادخال الايميل  ';
    } else */
    if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String? validateisNull(String value, String filed) {
    return null;
  }

  String? validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return " الحقل مطلوب ";
    }
    /*else if (value.length < 8) {
      return "Password must minimum eight characters";
    }
     else if (!regExp.hasMatch(value)) {
      return "Password at least one uppercase letter, one lowercase letter and one number";
    }*/
    return null;
  }

  String? validateNumberNonZero(String value, String filed) {
    if (value.isEmpty) {
      return "الرجال إدخال $filed";
    }
    /*String pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'الرقم المدخل غير صحيح';
    }*/
    if (double.parse(value) <= 0) {
      return 'الرقم المدخل غير صالح';
    }
    return null;
  }

///////////
}
