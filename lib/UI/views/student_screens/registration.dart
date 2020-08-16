import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/constant/app_constant.dart';

import 'package:booksharing/core/viewModels/student_provider/studentRegModel.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Registration extends StatelessWidget {
  static final tag = RoutePaths.Register;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentRegModel>(builder: (context, studentRegModel, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Registration", style: textStyle),
        ),
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: RegistrationForm(
              scaffoldKey: scaffoldKey,
              studentRegModel: studentRegModel,
            ),
          ),
        ),
      );
    });
  }
}

// class CollegeYear extends StatelessWidget {
//   const CollegeYear({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     StudentRegModel studentRegModel = Provider.of(context);
//     return DropdownButton(
//         value: studentRegModel.collegeYear,
//         isExpanded: true,
//         // isDense: false,
//         hint: Text("Choose Year"),
//         items: ["1", "2", "3", "4"].map((e) {
//           return DropdownMenuItem(
//             child: Text(e.toString()),
//             value: e,
//           );
//         }).toList(),
//         onChanged: (val) {
//           studentRegModel.chooseCollegeYear(val);
//         });
//   }
// }

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

class RegistrationForm extends StatelessWidget {
  final StudentRegModel studentRegModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const RegistrationForm({Key key, this.studentRegModel, this.scaffoldKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: studentRegModel.autoValidate,
      key: studentRegModel.formKey,
      child: Column(
        children: <Widget>[
          // TextFormField(
          //   textCapitalization: TextCapitalization.words,
          //   controller: studentRegModel.enrollmentNo,
          //   decoration: InputDecoration(
          //     hintText: "Enrollment Number",
          //     suffixIcon: Icon(FontAwesomeIcons.university),
          //   ),
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please enter Enrollement Number';
          //     } else if (value.length < 13) {
          //       return "Please enter Right Enrollment Number";
          //     } else if (!value.startsWith("E17")) {
          //       return "Please enter Right Enrollment Number";
          //     }
          //     return null;
          //   },
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          // ),
          // SizedBox(
          //   height: 40,
          // ),
          // SvgPicture.asset(
          //   "assets/svg/undraw_profile_6l1l.svg",
          //   width: MediaQuery.of(context).size.width / 2,
          //   // color: Color(0xFF313457),
          //   allowDrawingOutsideViewBox: true,
          //   // fit: BoxFit.fill,
          //   height: 250,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
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
            textCapitalization: TextCapitalization.words,
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
                return 'Please enter Email Address';
              }
              if (!isEmail(value)) {
                return "Please enter valid Email";
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
              // print(double.tryParse(value));
              if (value.isEmpty) {
                return 'Please enter Age';
              } else if (double.tryParse(value) <= 0.0 ||
                  double.tryParse(value) > 112.0) {
                return "Please enter valid Age";
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          // TextFormField(
          //   textCapitalization: TextCapitalization.words,
          //   controller: studentRegModel.collegeName,
          //   decoration: InputDecoration(
          //     hintText: "College Name",
          //     suffixIcon: Icon(
          //       Icons.domain,
          //     ),
          //   ),
          //   keyboardType: TextInputType.text,
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please enter College Name';
          //     }
          //     return null;
          //   },
          // ),
          // SizedBox(
          //   height: 40,
          // ),
          // Text("Choose College Year"),
          // CollegeYear(),
          // SizedBox(
          //   height: 40,
          // ),
          // TextFormField(
          //   textCapitalization: TextCapitalization.words,
          //   controller: studentRegModel.course,
          //   decoration: InputDecoration(
          //     hintText: "Course",
          //     suffixIcon: Icon(
          //       FontAwesomeIcons.graduationCap,
          //     ),
          //   ),
          //   keyboardType: TextInputType.text,
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please enter Course';
          //     }
          //     return null;
          //   },
          // ),
          // SizedBox(
          //   height: 40,
          // ),
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
            textCapitalization: TextCapitalization.words,
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
                flex: 4,
                child: CountryPickerDropdown(
                  initialValue: 'in',
                  itemBuilder: _buildDropdownItem,
                  onValuePicked: (Country country) {
                    studentRegModel.countryCode = country.phoneCode;
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
                    studentRegModel
                        .setPhoneNumber(studentRegModel.countryCode + val);
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
              ? Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(studentRegModel.file),
                    ),
                  ),
                )
              : Container(),
          RaisedButton(
            onPressed: () {
              studentRegModel.registerStudentProvider(context, scaffoldKey);
            },
            child: Text(
              "Register",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
