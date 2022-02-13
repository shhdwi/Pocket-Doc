import 'package:get/get.dart';
import 'package:pocket_doc/controller/db/db_helper.dart';
import 'package:pocket_doc/models/medicine.dart';
class MedicineController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var medList =<Medicine>[].obs;

  Future<int> addMedicine({Medicine? medicine}) async {
    return  await DBHelper.insert(medicine);
  }
  void getMedicine() async
  {
    List<Map<String,dynamic>> meds = await DBHelper.query();
    medList.assignAll(meds.map((data) => new Medicine.fromJson(data)).toList());

  }
  void  delete(Medicine medicine){
    DBHelper.delete(medicine);

  }

}