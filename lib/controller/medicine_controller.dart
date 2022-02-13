import 'package:get/get.dart';
import 'package:pocket_doc/controller/db/db_helper.dart';
import 'package:pocket_doc/models/medicine.dart';
class MedicineController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  Future<int> addMedicine({Medicine? medicine}) async {
    return  await DBHelper.insert(medicine);
  }

}