import 'dart:ui';

import 'package:finance_app/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/screens/login.dart';
import 'package:finance_app/theme.dart';
import 'package:finance_app/widgets/primary_button.dart';
import 'package:finance_app/widgets/checkbox.dart';
import 'package:finance_app/widgets/signup_form.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/firestore_utils.dart';
import '../data/shared_prefs.dart';
import '../widgets/bottomnavigationbar.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Create Account',
                style: titleText,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Already a member?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: kDefaultPadding,
              child: SignUpForm(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: CheckBox('Agree to terms and conditions.'),
            ),
            SizedBox(
              height: 20,
            ),
            SignInButton(
              padding: kDefaultPadding,
              Buttons.Google,
              text: "OR Sign up with Google",
              onPressed: () {},
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: kDefaultPadding,
              child: InkWell(
                  onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Bottom()));
                },
                child: InkWell(
                  onTap: (){
                    addDataToSharedPrefs();
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Bottom()));
                  },
                  child: PrimaryButton(buttonText: 'Sign Up'))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
