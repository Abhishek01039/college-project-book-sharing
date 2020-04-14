import 'dart:io';

import 'package:booksharing/UI/shared/commonUtility.dart';

import 'package:booksharing/core/viewModels/studentRegModel.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Registration extends StatelessWidget {
  static final tag = 'registration';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String countryCode = "+91";
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentRegModel>(builder: (context, studentRegModel, _) {
      return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: studentRegModel.formKey,
                child: Column(
                  children: <Widget>[
                    Text("Registration", style: textStyle),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.enrollmentNo,
                      decoration: InputDecoration(
                        hintText: "Enrollment Number",
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Enrollement Number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.firstName,
                      decoration: InputDecoration(
                        hintText: "First Name",
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter First Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.lastName,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        suffixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Last Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.email,
                      decoration: InputDecoration(
                        hintText: "Email",
                        suffixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.age,
                      decoration: InputDecoration(
                        hintText: "Age",
                        suffixIcon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Age';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.collegeName,
                      decoration: InputDecoration(
                        hintText: "College Name",
                        suffixIcon: Icon(
                          FontAwesomeIcons.graduationCap,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter College Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Choose College Year"),
                    CollegeYear(),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.course,
                      decoration: InputDecoration(
                        hintText: "Course",
                        suffixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Course';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 5) {
                          return 'Password must be more than five characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.confirmPass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: Icon(Icons.lock_open),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Confirm Password';
                        } else if (value != studentRegModel.password.text) {
                          return 'Password is not same';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: studentRegModel.address,
                      decoration: InputDecoration(
                        hintText: "Address",
                        suffixIcon: Icon(
                          FontAwesomeIcons.addressBook,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: CountryPickerDropdown(
                            initialValue: 'in',
                            itemBuilder: _buildDropdownItem,
                            onValuePicked: (Country country) {
                              countryCode = country.phoneCode;
                              // print("${country.name}");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          // child: TextFormField(
                          //   controller: new TextEditingController.fromValue(
                          //       new TextEditingValue(
                          //           text: studentRegModel.number,
                          //           selection: new TextSelection.collapsed(
                          //               offset:
                          //                   studentRegModel.number.length - 1))),
                          //   keyboardType: TextInputType.text,
                          //   onChanged: (value) {
                          //     studentRegModel.setPhoneNumber(value);
                          //     // var sel = studentRegModel.phoneNumber.selection;
                          //     // studentRegModel.phoneNumber.selection = sel;
                          //     // final val = TextSelection.collapsed(
                          //     //     offset: studentRegModel.phoneNumber.text.length);
                          //     // studentRegModel.phoneNumber.selection = val;
                          //     var cursorPos =
                          //         studentRegModel.phoneNumber.selection;

                          //     studentRegModel.phoneNumber.text = value ?? '';

                          //     if (cursorPos.start >
                          //         studentRegModel.phoneNumber.text.length) {
                          //       cursorPos = new TextSelection.fromPosition(
                          //           new TextPosition(
                          //               offset: studentRegModel
                          //                   .phoneNumber.text.length));
                          //     }
                          //     studentRegModel.phoneNumber.selection = cursorPos;
                          //     studentRegModel.setPhoneNumber(value);
                          //     print(value);
                          //   },
                          // ),
                          child: TextFormField(
                            // controller: studentRegModel.phoneNumber,
                            keyboardType: TextInputType.number,

                            // initialValue: studentRegModel.number.substring(3),
                            onChanged: (val) {
                              studentRegModel.number = "";
                              studentRegModel.setPhoneNumber(countryCode + val);
                              // print("hello");
                              // print(studentRegModel.number);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Choose Profile Image"),
                        InkWell(
                          onTap: () {
                            studentRegModel.chooseImage();
                          },
                          child: Icon(Icons.photo_album),
                        ),
                      ],
                    ),
                    studentRegModel.file != null
                        ? Image.file(studentRegModel.file)
                        : Container(),
                    RaisedButton(
                      onPressed: () {
                        studentRegModel.registerStudent(context, scaffoldKey);
                      },
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CollegeYear extends StatelessWidget {
  const CollegeYear({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentRegModel studentRegModel = Provider.of(context);
    return DropdownButton(
        value: studentRegModel.collegeYear,
        isExpanded: true,
        // isDense: false,
        hint: Text("Choose Year"),
        items: ["1", "2", "3", "4"].map((e) {
          return DropdownMenuItem(
            child: Text(e.toString()),
            value: e,
          );
        }).toList(),
        onChanged: (val) {
          studentRegModel.chooseCollegeYear(val);
        });
  }
}

Widget _buildDropdownItem(Country country) => Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}(${country.isoCode})"),
        ],
      ),
    );
