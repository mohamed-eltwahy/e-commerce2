import 'package:buy_it/Screens/signup_screen.dart';
import 'package:buy_it/admin/adminhome.dart';
import 'package:buy_it/home.dart';
import 'package:buy_it/provider/admin_mode.dart';
import 'package:buy_it/provider/modelhud.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:buy_it/utilities/sharedtextfield.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  final adminpass = 'admin12345';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmaincolor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isloading,
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: ExactAssetImage('images/icons/cart.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              customtextfield('Email', Icons.email, false, 'enter you email',
                  (value) {
                _email = value;
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              customtextfield(
                  'Password', Icons.vpn_key, true, 'enter you password',
                  (value) {
                _password = value;
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              underBotton('Login'),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an Account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUp.id);
                    },
                    child: Text('Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Pacifico',
                        )),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(true);
                        },
                        child: Text(
                          "i'm an Admin",
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 16,
                            color: Provider.of<AdminMode>(context).isadmin
                                ? kmaincolor
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(false);
                        },
                        child: Text(
                          "i'm a User",
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 16,
                            color: Provider.of<AdminMode>(context).isadmin
                                ? Colors.white
                                : kmaincolor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget underBotton(String bottonname) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: Builder(
        builder: (context) => RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Color(0xFF010004),
            child: Text(
              bottonname,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            onPressed: (){
              _validate(context);
            }),
      ),
    );
  }

  Future<void> _validate(BuildContext context) async {
    final modalhud = Provider.of<ModalHud>(context, listen: false);
    modalhud.changeisloading(true);
    if (_key.currentState.validate()) {
      _key.currentState.save();
      if (Provider.of<AdminMode>(context,listen: false).isadmin) {
        if (_password == adminpass) {
          try {
            await _auth.signin(_email.trim(), _password.trim());
            modalhud.changeisloading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modalhud.changeisloading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('something went wrong!'),
          ));
        }
      } else {
        try {
          await _auth.signin(_email, _password);
          modalhud.changeisloading(false);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          modalhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modalhud.changeisloading(false);
  }
}
