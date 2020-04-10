import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/studentEditModel.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class StudentEdit extends StatelessWidget {
  static final tag = 'studentEdit';
  final Student student;

  StudentEdit({Key key, this.student}) : super(key: key);
  String countryCode = "+91";
  @override
  Widget build(BuildContext context) {
    StudentEditModel studentEditModel = Provider.of(context);
    studentEditModel.enrollmentNo.text = student.enrollmentNo;
    studentEditModel.firstName.text = student.firstName;
    studentEditModel.lastName.text = student.lastName;
    studentEditModel.email.text = student.email;
    studentEditModel.age.text = student.age.toString();
    studentEditModel.collegeName.text = student.collegeName;
    studentEditModel.course.text = student.course;
    studentEditModel.address.text = student.address;

    studentEditModel.number = student.contactNo;
    studentEditModel.collegeYear = student.collegeYear.toString();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: studentEditModel.formKey,
              child: Column(
                children: <Widget>[
                  Text("Registration", style: textStyle),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: studentEditModel.enrollmentNo,
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
                    controller: studentEditModel.firstName,
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
                    controller: studentEditModel.lastName,
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
                    controller: studentEditModel.email,
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
                    controller: studentEditModel.age,
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
                    controller: studentEditModel.collegeName,
                    decoration: InputDecoration(
                      hintText: "College Name",
                      suffixIcon: FaIcon(
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
                    controller: studentEditModel.course,
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
                    controller: studentEditModel.address,
                    decoration: InputDecoration(
                      hintText: "Address",
                      suffixIcon: FaIcon(
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
                  // InternationalPhoneNumberInput(
                  //   onInputChanged: (PhoneNumber number) {
                  //     // print(number.p`honeNumber);
                  //     studentEditModel.setPhoneNumber(number.phoneNumber);
                  //   },
                  //   textFieldController: studentEditModel.phoneNumber,
                  //   isEnabled: true,

                  //   locale: studentEditModel.number,
                  //   countries: ["IN"],
                  //   initialCountry2LetterCode: "+91",
                  //   autoValidate: true,
                  //   formatInput: false,

                  //   ignoreBlank: true,
                  // ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: CountryPickerDropdown(
                          initialValue: 'in',
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (Country country) {
                            countryCode = country.phoneCode;
                            print("${country.name}");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        // child: TextFormField(
                        //   controller: new TextEditingController.fromValue(
                        //       new TextEditingValue(
                        //           text: studentEditModel.number,
                        //           selection: new TextSelection.collapsed(
                        //               offset:
                        //                   studentEditModel.number.length - 1))),
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (value) {
                        //     studentEditModel.setPhoneNumber(value);
                        //     // var sel = studentEditModel.phoneNumber.selection;
                        //     // studentEditModel.phoneNumber.selection = sel;
                        //     // final val = TextSelection.collapsed(
                        //     //     offset: studentEditModel.phoneNumber.text.length);
                        //     // studentEditModel.phoneNumber.selection = val;
                        //     var cursorPos =
                        //         studentEditModel.phoneNumber.selection;

                        //     studentEditModel.phoneNumber.text = value ?? '';

                        //     if (cursorPos.start >
                        //         studentEditModel.phoneNumber.text.length) {
                        //       cursorPos = new TextSelection.fromPosition(
                        //           new TextPosition(
                        //               offset: studentEditModel
                        //                   .phoneNumber.text.length));
                        //     }
                        //     studentEditModel.phoneNumber.selection = cursorPos;
                        //     studentEditModel.setPhoneNumber(value);
                        //     print(value);
                        //   },
                        // ),
                        child: TextFormField(
                          // controller: studentEditModel.phoneNumber,
                          keyboardType: TextInputType.number,

                          initialValue: studentEditModel.number.substring(3),
                          onChanged: (val) {
                            studentEditModel.number = "";
                            studentEditModel.setPhoneNumber(countryCode + val);
                            // print("hello");
                            // print(studentEditModel.number);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      studentEditModel.updateStudent().then((value) {
                        if (value) {
                          SPHelper.setString("enrollmentNo",
                              studentEditModel.enrollmentNo.text);
                          SPHelper.setString(
                              "studentName", studentEditModel.firstName.text);

                          studentEditModel.enrollmentNo.clear();
                          studentEditModel.firstName.clear();
                          studentEditModel.lastName.clear();
                          studentEditModel.email.clear();
                          studentEditModel.age.clear();
                          studentEditModel.collegeName.clear();
                          studentEditModel.course.clear();

                          // studentEditModel.phoneNumber.clear();
                          studentEditModel.address.clear();
                          studentEditModel.number = "";

                          // Navigator.pushReplacementNamed(context, 'home');
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'home',
                            (Route<dynamic> route) => false,
                          );
                          showFlutterToast("Update Successfully");
                        } else {
                          showFlutterToast(
                              "Somthing went wrong Please try again");
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Update Profile",
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
  }
}

class CollegeYear extends StatelessWidget {
  const CollegeYear({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentEditModel studentEditModel = Provider.of(context);

    return DropdownButton(
        value: studentEditModel.collegeYear,
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
          studentEditModel.chooseCollegeYear(val);
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
