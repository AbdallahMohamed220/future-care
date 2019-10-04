import 'package:flutter/material.dart';
import 'package:future_care/providers/auth.dart';
import 'package:provider/provider.dart';

class EditeAccount extends StatefulWidget {
  static const routeName = 'edit_product';

  @override
  _EditeAccountState createState() => _EditeAccountState();
}

class _EditeAccountState extends State<EditeAccount> {
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userAddressController = TextEditingController();
  var _isloading = false;

  final _formKey = GlobalKey<FormState>();
  var _editUser = Auth(
      userName: '',
      userEmail: '',
      userPassword: '',
      userPhoneNumber: '',
      userAddress: '');
  var _isInt = true;
  var userId;

  @override
  void didChangeDependencies() {
    if (_isInt) {
      userId = Provider.of<Auth>(context).userId;
      if (userId != null) {
        _userNameController.text = Provider.of<Auth>(context).userName;
        _userEmailController.text = Provider.of<Auth>(context).userEmail;
        _userPasswordController.text = Provider.of<Auth>(context).userPassword;
        _userPhoneController.text = Provider.of<Auth>(context).userPhoneNumber;
        _userAddressController.text = Provider.of<Auth>(context).userAddress;
      }
    }
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isloading = true;
    });

    try {
      if (_editUser.userId != null) {
        await Provider.of<Auth>(context, listen: false).updateUser(
            userId,
            _userNameController.text,
            _userEmailController.text,
            _userPasswordController.text,
            _userAddressController.text,
            _userPhoneController.text);
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              child: Icon(Icons.save),
              onTap: () {
                _saveForm();
              },
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 10) {
                            return 'Enter valid Value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editUser = Auth(
                              userId: userId,
                              userName: value,
                              userEmail: _userEmailController.text,
                              userPassword: _userPasswordController.text,
                              userAddress: _userAddressController.text,
                              userPhoneNumber: _userPhoneController.text);
                        },
                        decoration: InputDecoration(labelText: 'Full Name'),
                      ),
                      TextFormField(
                        controller: _userEmailController,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editUser = Auth(
                              userId: userId,
                              userName: _userNameController.text,
                              userEmail: value,
                              userPassword: _userPasswordController.text,
                              userAddress: _userAddressController.text,
                              userPhoneNumber: _userPhoneController.text);
                        },
                        decoration: InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: _userPasswordController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 8) {
                            return 'Enter valid Value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editUser = Auth(
                              userId: userId,
                              userName: _userNameController.text,
                              userEmail: _userEmailController.text,
                              userPassword: value,
                              userAddress: _userAddressController.text,
                              userPhoneNumber: _userPhoneController.text);
                        },
                        decoration: InputDecoration(
                          labelText: 'password',
                        ),
                      ),
                      TextFormField(
                        controller: _userAddressController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 8) {
                            return 'Enter valid Value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editUser = Auth(
                              userId: userId,
                              userName: _userNameController.text,
                              userEmail: _userEmailController.text,
                              userPassword: _userPasswordController.text,
                              userAddress: value,
                              userPhoneNumber: _userPhoneController.text);
                        },
                        decoration: InputDecoration(
                          labelText: 'Address',
                        ),
                      ),
                      TextFormField(
                        controller: _userPhoneController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 11) {
                            return 'Enter valid Value';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editUser = Auth(
                              userId: userId,
                              userName: _userNameController.text,
                              userEmail: _userEmailController.text,
                              userPassword: _userPasswordController.text,
                              userAddress: _userAddressController.text,
                              userPhoneNumber: value);
                        },
                        decoration: InputDecoration(
                          labelText: 'phone Nmber',
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
