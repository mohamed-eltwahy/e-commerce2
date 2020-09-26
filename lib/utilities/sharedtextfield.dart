import 'package:buy_it/utilities/constants.dart';
import 'package:flutter/material.dart';

Widget customtextfield(
    String hint, IconData iconData, bool val, String errortype,Function onclick) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return errortype;
        }
        return null;
      },
      onSaved: onclick,
      obscureText: val,
      cursorColor: kmaincolor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
          color: kmaincolor,
        ),
        filled: true,
        fillColor: ktextfieldcolor,
        hintText: hint,
        hintStyle: TextStyle(fontFamily: 'Pacifico'),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

// Widget underBotton(String bottonname) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 120),
//     child: RaisedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         color: Color(0xFF010004),
//         child: Text(
//           bottonname,
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'Pacifico',
//           ),
//         ),
//         onPressed: () {
//            _key.currentState.validate();
//         }),
//   );
// }

// Widget textunderbotton1(String hinttext, String bottonname) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Text(hinttext,
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'Pacifico',
//           )),
//       GestureDetector(
//         onTap: () {
//           Navigator.pushNamed(context, SingnUp.id);
//         },
//         child: Text(bottonname,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'Pacifico',
//             )),
//       ),
//     ],
//   );
// }
