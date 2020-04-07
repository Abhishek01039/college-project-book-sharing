import 'package:booksharing/core/viewModels/postedBookModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PostedBook extends StatelessWidget {
  static final tag = "postedBook";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Book"),
      ),
      body: Consumer<PostedBookModel>(
        builder: (context, postedBookModel, child) {
          return SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: postedBookModel.bookName,
                      decoration: InputDecoration(
                        hintText: "Book Name",
                        suffixIcon: FaIcon(FontAwesomeIcons.book),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Book Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.isbnNo,
                      decoration: InputDecoration(
                        hintText: "ISBN Number",
                        suffixIcon: FaIcon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter ISBN Number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.authorName,
                      decoration: InputDecoration(
                        hintText: "Author Name",
                        suffixIcon: FaIcon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Author Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.pubName,
                      decoration: InputDecoration(
                        hintText: "Publisher Name",
                        suffixIcon: FaIcon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Publisher Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.mrpPrice,
                      decoration: InputDecoration(
                        hintText: "MRP price",
                        suffixIcon: FaIcon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter MRP Price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.price,
                      decoration: InputDecoration(
                        hintText: "Price",
                        suffixIcon: FaIcon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: postedBookModel.bookCatgName,
                      decoration: InputDecoration(
                        hintText: "Book Category Name",
                        suffixIcon: FaIcon(FontAwesomeIcons.sortNumericUp),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Book Category Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Choose Book Image"),
                        InkWell(
                          onTap: () {
                            postedBookModel.chooseBookImage();
                          },
                          child: Icon(Icons.image),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Post Book"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
