import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override 
  State<StatefulWidget> createState() => new _LoginPageState();

}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndsave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('form is valid. $_email and $_password');
      return true;
    }
    return false;
  }

  void validateAndSubmit() async{
    if (validateAndsave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        }
        else {
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 125.0, 0.0, 0.0),
                    child: Text('welcome',
                        style: TextStyle(
                            fontSize: 70.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 205.0, 0.0, 0.0),
                    child: Text('foodie',
                        style: TextStyle(
                            fontSize: 70.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(235.0, 190.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            new Container(
                padding: EdgeInsets.only(top: 65.0, left: 20.0, right: 20.0),
                child: new Form(
                  key: formKey,
                  child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + buildSubmitButtons(),
                )),
                )
          ],
        ));
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(
            labelText: 'EMAIL',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
            validator: (value) => value.isEmpty ? 'Email field empty' : null,
            onSaved: (value) => _email = value
      ),
      SizedBox(height: 25),
      TextFormField(
        decoration: InputDecoration(
            labelText: 'PASSWORD',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password field empty' : null,
        onSaved: (value) => _password = value
      ),
      SizedBox(height: 5.0),
      Container(
        alignment: Alignment(1.0, 0.0),
        padding: EdgeInsets.only(top: 15.0, left: 20.0),
        child: InkWell(
          child: Text(
            'Forgot Password',
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    ];

  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        SizedBox(height: 20),
        new RaisedButton( 
          child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          elevation: 7.0,
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.green),
          ),
          onPressed: validateAndSubmit,
        ),
        SizedBox(height: 15.0),
        new FlatButton(onPressed: moveToRegister, 
          child: new Text('New to foodie? Register', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))
      ];
    }
    else {
      return [
        SizedBox(height: 20),
        new RaisedButton( 
          child: Text('Register as foodie!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          elevation: 7.0,
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.green),
          ),
          onPressed: validateAndSubmit,
        ),
        SizedBox(height: 15.0),
        new FlatButton(onPressed: moveToLogin, 
          child: new Text('Already a foodie? Login', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)))
      ];
    }
  }
}