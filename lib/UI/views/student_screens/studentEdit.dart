import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/constant/app_constant.dart';
// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/student_provider/studentEditModel.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/countries.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class StudentEdit extends StatelessWidget {
  StudentEdit({Key key, this.student})
      : assert(
          student.email != null,
          student.firstName != null,
        ),
        assert(student.lastName != null),
        super(key: key);

  static final tag = RoutePaths.StudentEdit;
  final Student student;
  Country country = new Country();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Country getCountryByIsoCode(String countryCode) {
    try {
      return countryList.firstWhere(
        (country) => country.phoneCode == countryCode,
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  @override
  Widget build(BuildContext context) {
    StudentEditModel studentEditModel = Provider.of<StudentEditModel>(context);
    if (studentEditModel.autoValidate == false) {
      // studentEditModel.enrollmentNo.text = student.email;
      studentEditModel.firstName.text = student.firstName;
      studentEditModel.lastName.text = student.lastName;
      studentEditModel.email.text = student.email;
      studentEditModel.age.text = student.age.toString();
      // studentEditModel.collegeName.text = student.collegeName;
      // studentEditModel.course.text = student.course;
      studentEditModel.address.text = student.address;

      studentEditModel.number = student.contactNo;
      // studentEditModel.collegeYear = student.collegeYear.toString();
      studentEditModel.countryCode = student.contactNo.substring(1, 3);
      country = getCountryByIsoCode(studentEditModel.countryCode);
    }
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Edit Your Profile"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              autovalidateMode: studentEditModel.autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              key: studentEditModel.formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: studentEditModel.firstName,
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: studentEditModel.lastName,
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: studentEditModel.email,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      suffixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!isEmail(value)) {
                        return "Please enter valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: studentEditModel.age,
                    decoration: const InputDecoration(
                      hintText: "Age",
                      suffixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Age';
                      } else if (int.tryParse(value) <= 0 &&
                          int.tryParse(value) > 112) {
                        return "Please enter valid Age";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: studentEditModel.address,
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: CountryPickerDropdown(
                          initialValue: country.isoCode,
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (Country country) {
                            studentEditModel
                                .changeCountryCode(country.phoneCode);

                            // print("$countryCode");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          // controller: studentEditModel.phoneNumber,
                          keyboardType: TextInputType.number,

                          initialValue: studentEditModel.number.substring(3),
                          onChanged: (val) {
                            // studentEditModel.number = "";
                            studentEditModel.updatePhoneNumber(val);
                            // print("hello");
                            // print(studentEditModel.number);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      final box = Hive.box("Student");
                      studentEditModel
                          .updateStudentProvider(scaffoldKey)
                          .then((value) {
                        if (value == "true") {
                          box.put("email", studentEditModel.email.text);
                          box.put(
                              "studentName", studentEditModel.firstName.text);

                          studentEditModel.firstName.clear();
                          studentEditModel.lastName.clear();
                          studentEditModel.email.clear();
                          studentEditModel.age.clear();

                          studentEditModel.address.clear();
                          studentEditModel.number = "";

                          Navigator.pop(context);
                          Navigator.pop(context);
                          showFlutterToast("Update Successfully");
                          studentEditModel.formKey.currentState.reset();
                        } else if (value == "not valid") {
                          showFlutterToast("Contact Number is not Valid");
                        } else if (value == "") {
                          showFlutterToast("Please fill the form correctly");
                        } else if (value == null) {
                          showFlutterToast("Please fill the form correctly");
                        } else {
                          showFlutterToast(
                              "Somthing went wrong. Please try again");
                        }
                      });
                    },
                    child: const Text(
                      "Update Profile",
                      textAlign: TextAlign.center,
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

Widget _buildDropdownItem(Country country) => Container(
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: 8.0,
          ),
          Text("+${country.phoneCode}(${country.isoCode})"),
        ],
      ),
    );
