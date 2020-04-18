import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';

class BookDetailModel extends BaseModel {
  Student student = locator<Student>();
  Api api = locator<Api>();
  String postedBy;
  // give book whole detail according to ID and show it into book detail page
  getStudentDetail(int id) async {
    student = await api.getStudentById(id);
    return student;
  }

  floatingActionButtonEnable() {
    postedBy = "You";
    // print("You");
    notifyListeners();
  }
}
