import 'package:booksharing/UI/shared/commonUtility.dart';
import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/purchasedBook.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';

class PurchasedBookModel extends BaseModel with Api {
  List<PurchasedBook> purchasedBook = [];
  purchasedBookByUserProvider(int studId) async {
    var parsed = await purchasedBookByUser(studId);

    if (parsed != null) {
      purchasedBook.clear();
      for (var i in parsed) {
        purchasedBook.add(PurchasedBook.fromJson(i));
      }
    } else {
      showFlutterToast("Something went wrong");
    }

    return purchasedBook;
  }
}
