import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/viewmodel/base_model.dart';

class HeartServiceDetailModel extends BaseModel {
  late HeartService heartService;

  init(HeartService heartService) {
    heartService = heartService;
  }
}
