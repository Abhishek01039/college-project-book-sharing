// import 'package:booksharing/UI/views/shared_pref.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:booksharing/core/viewModels/book_provider/purchasedBookModel.dart';
import 'package:hive/hive.dart';

class MyPurchasedBook extends StatelessWidget {
  static final tag = RoutePaths.MyPurchasedBook;
  final box = Hive.box("Student");
  @override
  Widget build(BuildContext context) {
    PurchasedBookModel purchasedBookModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Purchased Book"),
      ),
      // it gives the tabular format of book which is purchased by student who is logged in App
      body: FutureBuilder(
        future: purchasedBookModel.purchasedBookByUserProvider(box.get("ID")),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? snapshot.data.length != 0
                  ? Column(
                      // width: MediaQuery.of(context).size.width,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/svg/undraw_successful_purchase_uyin.svg",
                            width: MediaQuery.of(context).size.width / 2,
                            // color: Color(0xFF313457),
                            // allowDrawingOutsideViewBox: true,
                            // fit: BoxFit.fill,
                            height: 250,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dataRowHeight: kMinInteractiveDimension,
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
                            rows: purchasedBookModel.purchasedBook
                                .map(
                                  (value) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          value.bookName,
                                          // overflow: TextOverflow.ellipsis,
                                          // maxLines: null,
                                          // softWrap: false,
                                        ),
                                      ),
                                      DataCell(
                                        Text(value.price.toString()),
                                      ),
                                      DataCell(
                                        Text(value.isbnNo),
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_shopping_cart,
                            size: 40,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text("No Purchased Book"),
                        ],
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
