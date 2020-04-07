import 'package:booksharing/core/API/allAPIs.dart';
import 'package:booksharing/core/models/student.dart';
import 'package:booksharing/core/viewModels/baseModel.dart';
import 'package:booksharing/locator.dart';

class BookDetailModel extends BaseModel {
  Student student = locator<Student>();
  Api api = locator<Api>();
  getStudentDetail(int id) async {
    student = await api.getStudentById(id);
    return student;
  }
}
