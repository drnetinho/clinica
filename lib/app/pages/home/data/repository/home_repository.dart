import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/home/data/types/home_types.dart';
import 'package:netinhoappclinica/app/pages/home/domain/model/app_details_model.dart';
import 'package:netinhoappclinica/common/services/firestore/firestore_collections.dart';

import '../../../../../common/error/app_error.dart';
import '../../../../../common/services/firestore/firestore_service.dart';
import '../../../../../core/helps/map_utils.dart';

abstract class HomeRepository {
  AppDetailsOrError getAppDetails();
}

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  @override
  AppDetailsOrError getAppDetails() async {
    try {
      final res = await FirestoreService.fire.collection(Collections.clinica).get();
      final docs = res.docs.map((e) {
        return addMapId(e.data(), e.id);
      }).toList();
      final data = AppDetailsModel.fromJson(docs.first);
      return (error: null, appDetails: data);
    } on FirebaseException {
      return (error: DomainError(), appDetails: null);
    } catch (e) {
      return (error: UndefiniedError(), appDetails: null);
    }
  }
}
