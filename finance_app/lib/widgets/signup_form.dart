import 'package:finance_app/Screens/home.dart';

import 'package:flutter/material.dart';
import 'package:finance_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/firestore_utils.dart';
import '../data/shared_prefs.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;
   TextEditingController  first_name_con = TextEditingController();
  TextEditingController  last_name_con = TextEditingController();
  TextEditingController  email_con = TextEditingController();
  TextEditingController  password_con= TextEditingController();
  TextEditingController  con_password_con= TextEditingController();
    final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences prefs;
  // FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addDataToSharedPrefs() async {
    if (_formKey.currentState!.validate()) {
      print("Valid");
      _formKey.currentState!.save();
      // prefs.setString(key, value)

      await createFirestoreData();
      _scaffoldKey.currentState?.showBottomSheet(
        (context) => Container(
          height: 100,
          color: kPrimaryColor,
          child: Center(
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home())),
                child: Text("Data Saved")),
          ),
        ),
      );

      // Navigator.pushNamed(context, Routes.home);
    }
  }
   Future<void> createFirestoreData() async {
    var response = FireStoreMethods.updateOrCreateFirestoreData(
      (prefs.getString(SharedPrefsConstant.firstname.toString()) ?? "No Name") +
          DateTime.now().millisecondsSinceEpoch.toString(),
      "users",
      {
        "firstname": prefs.getString(SharedPrefsConstant.firstname.toString()),
        "lastname":
            prefs.getString(SharedPrefsConstant.lastname.toString()),
        "email": prefs.getString(SharedPrefsConstant.email.toString()),
        "password":
            prefs.getString(SharedPrefsConstant.password.toString()),
        // "bloodGroup":
        //     prefs.getString(SharedPrefsConstant.bloodGroup.toString()),
      },
      isMerge: false,
    );
    debugPrint(response.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    onInit();
    super.initState();
  }

  // declaring a function so that the initState can call it without asynchrony
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('First Name', false,first_name_con),
        buildInputForm('Last Name', false,last_name_con),
        buildInputForm('Email', false,email_con),
        buildInputForm('Password', true,password_con),
        buildInputForm('Confirm Password', true,con_password_con),
      ],
    );
  }

  Padding buildInputForm(String hint, bool pass,TextEditingController controller){
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller:controller ,
          obscureText: pass ? _isObscure : false,
           onSaved: (newValue) => {
              newValue != null && newValue.isNotEmpty
                  ? prefs.setString(
                      controller.toString(),
                      newValue,
                    )
                  : prefs.setString(controller.toString(), ""),
              print(controller.toString()),
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }
}
