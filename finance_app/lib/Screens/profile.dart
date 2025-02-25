import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static Color my_color1 = Color.fromARGB(255, 128, 4, 150);
  Currency my_Currency = Currency(
      code: "INR",
      name: "Rupees",
      symbol: "₹",
      flag: "INR",
      number: 356,
      decimalDigits: 7,
      namePlural: "Rupees",
      symbolOnLeft: true,
      decimalSeparator: ".",
      thousandsSeparator: ",",
      spaceBetweenAmountAndSymbol: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                my_color1,
                                my_color1.withOpacity(0.8)
                              ])),
                    ),
                    Positioned(
                      bottom: -100,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 140,
                        height: 170,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: my_color1,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(10, 15))
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: <Color>[Colors.white, Colors.white])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 87, 3, 102),
                                boxShadow: [
                                  BoxShadow(
                                      color: my_color1,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(10, 15)),
                                ],
                              ),
                              child: Center(
                                  child: Text(
                                "P",
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white),
                              )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text("Profile"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 140,
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: my_color1,
                      padding: EdgeInsets.symmetric(horizontal: 20)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Text(
                    "Edit Prifile",
                  )),
              //
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListTile(
                  leading: Container(
                    width: 40,

                    height: 40,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: my_color1,
                    ), // BoxDecoration

                    child: const Icon(Icons.person),
                  ), // Container

                  title: Text("Test profile"),

                  trailing: Container(
                    width: 30,

                    height: 30,

                    // BoxDecoration
                  ), // Container
                ),
              ),
              InkWell(
                onTap: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) {
                      print('Select currency: ${currency.name}');
                      setState(() {});
                      my_Currency = currency;
                    },
                  );
                },
                child: ListTile(
                  leading: Container(
                    width: 40,

                    height: 40,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: my_color1,
                    ), // BoxDecoration

                    child: Image.asset('images/currency.png'),
                  ), // Container

                  title: Text(
                    "Currency : ${my_Currency.name}",
                  ),

                  trailing: Container(
                    width: 30,

                    height: 30,

                    // BoxDecoration
                  ), // Container
                ),
              ),

              ListTile(
                leading: Container(
                  width: 40,

                  height: 40,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: my_color1,
                  ), // BoxDecoration

                  child: const Icon(Icons.logout_rounded),
                ), // Container

                title: Text("Logout"),

                trailing: Container(
                  width: 30,

                  height: 30,

                  // BoxDecoration
                ), // Container
              ),
              // ListTile(
              //               leading: Container(
              //                 width: 40,

              //                 height: 40,

              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(100),
              //                   color: Colors.grey,
              //                 ), // BoxDecoration

              //                 child: const Icon(Icons.account_circle),
              //               ), // Container

              //               title: Text("Mahesh Komma"),

              //               trailing: Container(
              //                 width: 30,

              //                 height: 30,

              // // BoxDecoration
              //               ), // Container
              //             ), ListTile(
              //               leading: Container(
              //                 width: 40,

              //                 height: 40,

              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(100),
              //                   color: Colors.grey,
              //                 ), // BoxDecoration

              //                 child: const Icon(Icons.account_circle),
              //               ), // Container

              //               title: Text("Mahesh Komma"),

              //               trailing: Container(
              //                 width: 30,

              //                 height: 30,

              // // BoxDecoration
              //               ), // Container
              //             )
            ],
          ),
        ),
      ),
    );
  }
}
