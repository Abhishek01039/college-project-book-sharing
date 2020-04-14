import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/purchasedBookModel.dart';

class MyPurchasedBook extends StatelessWidget {
  static final tag = 'myPurchasedBook';
  @override
  Widget build(BuildContext context) {
    PurchasedBookModel purchasedBookModel = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Purchased Book"),
        ),
        body: FutureBuilder(
          future: purchasedBookModel.purchasedBookByUser(SPHelper.getInt("ID")),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? snapshot.data.length != 0
                    ? DataTable(
                        columns: [
                          DataColumn(
                            label: Text("Book Name"),
                          ),
                          DataColumn(
                            label: Text("Price"),
                          ),
                          DataColumn(
                            label: Text("ISBN number"),
                          ),
                        ],
                        rows: purchasedBookModel.purchasedBook.map(
                          (value) => DataRow(
                              cells: [
                                DataCell(
                                  Text(value.bookName),
                                ),
                                DataCell(
                                  Text(value.price.toString()),
                                ),
                                DataCell(
                                  Text(value.isbnNo),
                                )
                              ],
                            ),
                        ).toList(),
                      )
                    : Center(
                        child: Text("No Purchased Book"),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
