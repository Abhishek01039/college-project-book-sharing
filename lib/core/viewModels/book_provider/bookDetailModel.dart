import 'package:booksharing/core/API/allAPIs.dart';

import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';

class BookDetailModel extends BaseModel with Api {
  Student _student = locator<Student>();
  String postedBy;

  Future<Student> getStudentDetail(int id) async {
    _student = await getStudentById(id);
    return _student;
  }

  floatingActionButtonEnable() {
    postedBy = "You";

    notifyChange();
  }
}
