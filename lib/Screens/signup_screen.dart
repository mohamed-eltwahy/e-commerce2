import 'package:buy_it/Screens/login_screen.dart';
import 'package:buy_it/home.dart';
import 'package:buy_it/provider/modelhud.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:buy_it/utilities/sharedtextfield.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  static String id = 'signup';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
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
                height: MediaQuery.of(context).size.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: customtextfield(
                    'Enter your name', Icons.person, false, 'enter your name',
                    (value) {
                  return null;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: customtextfield(
                    'Entety your Email', Icons.email, false, 'enter your email',
                    (value) {
                  _email = value;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: customtextfield('Enter your Password', Icons.vpn_key,
                    true, 'enter your password', (value) {
                  _password = value;
                }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              underBotton('Sign Up'),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Do you have an Account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text('Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Pacifico',
                          )),
                    ),
                  ],
                ),
              )
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
            onPressed: () async {
              final modalhud = Provider.of<ModalHud>(context, listen: false);
              modalhud.changeisloading(true);
              if (_key.currentState.validate()) {
                _key.currentState.save();
                try {
                   await _auth.signup(_email.trim(), _password.trim());
                  modalhud.changeisloading(false);
                  Navigator.pushNamed(context, HomePage.id);
                } catch (e) {
                  modalhud.changeisloading(false);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(e.message),
                  ));
                }
              }
              modalhud.changeisloading(false);
            }),
      ),
    );
  }
}
