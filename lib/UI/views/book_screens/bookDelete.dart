import 'package:booksharing/core/viewModels/book_provider/postedBookModel.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDelete extends StatelessWidget {
  static final tag = "bookdelete";
  final int bookId;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BookDelete({Key key, this.bookId}) : super(key: key);
  String countryCode = "+91";
  @override
  Widget build(BuildContext context) {
    Future<void> _deleteBook(BuildContext ctx, PostedBookModel postedBookModel,
        int bookId, GlobalKey<ScaffoldState> scaffoldKey) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Want to delete Book?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              RaisedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, 'bookdelete');
                  Navigator.pop(ctx);
                  postedBookModel.deleteBookProvider(ctx, bookId, scaffoldKey);
                },
                child: Text("Yes"),
              )
            ],
          );
        },
      );
    }

    // student has to filled this detail if student sold this book.
    // student has to provide the name and mobile number of student who has sold this book.
    _showDeleteDialog(BuildContext con, PostedBookModel postedBookModel,
        GlobalKey<ScaffoldState> scaffoldKey) {
      return showDialog(
        context: con,
        builder: (con) {
          return AlertDialog(
            title: Text('To whom you sold your book?'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: postedBookModel.studentName,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: "Student Name",
                      suffixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Student Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // TextFormField(
                  //   // controller: studentRegModel.lastName,
                  //   decoration: InputDecoration(
                  //     hintText: "",
                  //     suffixIcon: Icon(Icons.person),
                  //   ),
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return 'Please enter Last Name';
                  //     }
                  //     return null;
                  //   },
                  //   keyboardType: TextInputType.text,
                  // ),
                  // SizedBox(
                  //   height: 40,
                  // ),
                  CountryPickerDropdown(
                    initialValue: 'in',
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (Country country) {
                      countryCode = country.phoneCode;
                      print("${country.name}");
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: studentEditModel.phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Phone Number"),
                    // initialValue: postedBookModel.number.substring(3),
                    onChanged: (val) {
                      postedBookModel.number = "";
                      postedBookModel.setPhoneNumber(countryCode + val);
                      // print("hello");
                      // print(studentEditModel.number);
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, 'bookdelete');
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BookDelete(
                  //       bookId: bookId,
                  //     ),
                  //   ),
                  // );
                  postedBookModel.deleteBookByTransaction(
                      context, bookId, scaffoldKey);
                },
                child: Text("Yes"),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Book Deletion"),
      ),
      body: Consumer<PostedBookModel>(
        builder: (context, postedBookModel, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // postedBookModel.deleteBook(context, bookId);
                      _deleteBook(
                          context, postedBookModel, bookId, scaffoldKey);
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Do You want to keep book with Yourself ?"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // postedBookModel.deleteBook(context, bookId);
                      _deleteBook(
                          context, postedBookModel, bookId, scaffoldKey);
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                            "Have you sold your book to anyone who is in your group ?"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showDeleteDialog(context, postedBookModel, scaffoldKey);
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text("Have you sold your book to anyone ?"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
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
