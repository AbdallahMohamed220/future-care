import 'package:flutter/material.dart';
import 'package:future_care/app_localization.dart';
import 'package:future_care/providers/auth.dart';
import 'package:provider/provider.dart';
import '../model/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 90,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                          fit: BoxFit.contain)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AuthCard(),
            ],
          ),
        ));
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'fullname': '',
    'email': '',
    'password': '',
    'address': '',
    'phonenumber': '',
  };
  var _isLoading = false;
  var _togggleVisiabilty = false;
  final _passwordController = TextEditingController();

  Future<String> _showDialogError(String message) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)
                  .translate('Something Went Wrong!')),
              content: Text(message.toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('okey')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .signIn(context, _authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['fullname'],
          _authData['email'],
          _authData['password'],
          _authData['address'],
          _authData['phonenumber'],
        );
      }
    } on HttpException catch (error) {
      var errorMessge = 'Authintication Faild';
      if (error.toString().contains('registration-error-email-exists')) {
        errorMessge = AppLocalizations.of(context).translate(
            'The email address is already in use by another account.');
      } else if (error.toString().contains('SOMETHING_WENT_WRONG')) {
        errorMessge = AppLocalizations.of(context)
            .translate('Please check your Email and password!');
      } else if (error.toString().contains('Sign Up Done')) {
        errorMessge = AppLocalizations.of(context)
            .translate('Sign Up Done please Sign in');
        _authData['fullname'] = '';
        _authData['email'] = "";
        _authData['password'] = "";
        _authData['address'] = "";
        _authData['phonenumber'] = "";
      }

      _showDialogError(errorMessge);
    } catch (error) {
      print(error);
      var errorMessage = AppLocalizations.of(context)
          .translate('Could Not Athunticate you, Please try again');
      _showDialogError(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthModeLogin() {
    if (_authMode == AuthMode.Signup) {
      setState(() {
        _authMode = AuthMode.Login;
      });
    } else if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _switchAuthModeSingUp() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else if (_authMode == AuthMode.Signup) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height + 100,
      width: deviceSize.width * 0.7,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      AppLocalizations.of(context).translate('LOGIN'),
                      style: _authMode == AuthMode.Login
                          ? TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                    ),
                    onPressed: _switchAuthModeLogin,
                  ),
                  FlatButton(
                    child: Text(
                      AppLocalizations.of(context).translate('SIGNUP'),
                      style: _authMode == AuthMode.Signup
                          ? TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                    ),
                    onPressed: _switchAuthModeSingUp,
                  ),
                ]),
            if (_authMode == AuthMode.Signup)
              SizedBox(
                height: 10,
              ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate('Full Name'),
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('Value Is Empty!');
                  }
                  if (value.length < 10) {
                    return AppLocalizations.of(context)
                        .translate('Name is soo short please type full name!');
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['fullname'] = value;
                },
              ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).translate('Email'),
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return AppLocalizations.of(context)
                      .translate('Value Is Empty!');
                }
                if (!value.contains('@')) {
                  return AppLocalizations.of(context)
                      .translate('Invalid Email!');
                }
                if (value.length < 15) {
                  return AppLocalizations.of(context)
                      .translate('Email is soo short');
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: !_togggleVisiabilty
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _togggleVisiabilty = !_togggleVisiabilty;
                    });
                  },
                ),
                hintText: AppLocalizations.of(context).translate('password'),
                hintStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(16),
              ),
              obscureText: !_togggleVisiabilty,
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return AppLocalizations.of(context)
                      .translate('Value Is Empty!');
                }
                if (value.length < 6) {
                  return AppLocalizations.of(context)
                      .translate('Password Is Too Short!');
                }

                return null;
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)
                      .translate('Confirm Password'),
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                enabled: _authMode == AuthMode.Signup,
                obscureText: true,
                validator: _authMode == AuthMode.Signup
                    ? (value) {
                        if (value != _passwordController.text) {
                          return AppLocalizations.of(context)
                              .translate('Passwords do not match!');
                        }
                        return null;
                      }
                    : null,
              ),
            SizedBox(
              height: 10,
            ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate('Address'),
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('Value Is Empty!');
                  }
                  if (value.length < 10) {
                    return AppLocalizations.of(context)
                        .translate('address is soo short please add more!');
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['address'] = value;
                },
              ),
            SizedBox(
              height: 10,
            ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context).translate('Phone Number'),
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('Value Is Empty!');
                  }
                  if (value.length < 11) {
                    return AppLocalizations.of(context)
                        .translate('Phone number is soo short');
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['phonenumber'] = value;
                },
              ),
            if (_authMode == AuthMode.Login)
              if (_isLoading)
                CircularProgressIndicator()
              else
                Container(
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () => _submit(),
                    child: Text(
                      AppLocalizations.of(context).translate('LOGIN_Button'),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            if (_authMode == AuthMode.Signup)
              SizedBox(
                height: 15,
              ),
            if (_authMode == AuthMode.Signup)
              if (_isLoading)
                CircularProgressIndicator()
              else
                Container(
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () => _submit(),
                    child: Text(AppLocalizations.of(context)
                        .translate('Signup_Button')),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
          ],
        ),
      ),
    );
  }
}
