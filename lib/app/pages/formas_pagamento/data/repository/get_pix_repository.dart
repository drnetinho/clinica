import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/common/either/either.dart';

import '../../../../../common/error/app_error.dart';
import '../../../../../common/services/firestore/firestore_collections.dart';
import '../../../../../common/services/firestore/firestore_service.dart';
import '../../../../../common/services/logger.dart';
import '../../../../../core/helps/map_utils.dart';

import '../../domain/model/pix_model.dart';
import '../types/pix_types.dart';

abstract class GetPixRepository {
  GetPixOrError getPix();
  EditPixOrError updatePix({required PixModel pix});
}

@Injectable(as: GetPixRepository)
class GetPixRepositoryImpl implements GetPixRepository {
  final FirestoreService service;

  GetPixRepositoryImpl({
    required this.service,
  });

  @override
  GetPixOrError getPix() async {
    try {
      final response = await FirestoreService.fire.collection(FirestoreCollections.pix).get();

      final docs = response.docs.map((e) => addMapId(e.data(), e.id)).toList();

      final data = docs.map((e) => PixModel.fromJson(e)).toList();
      Logger.prettyPrint(data, Logger.greenColor);

      return (error: null, pix: data.first);
    } on FirebaseException {
      return (error: RemoteError(), pix: null);
    }
  }

  @override
  EditPixOrError updatePix({required PixModel pix}) async {
    try {
      await FirestoreService.fire.collection(FirestoreCollections.pix).doc(pix.id).update(pix.toJson());
      Logger.prettyPrint(pix, Logger.greenColor);
      return (error: null, unit: unit);
    } on FirebaseException {
      return (error: RemoteError(), unit: null);
    }
  }
}
