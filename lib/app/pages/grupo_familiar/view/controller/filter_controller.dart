import 'package:injectable/injectable.dart';
import 'package:netinhoappclinica/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:netinhoappclinica/core/helps/extension/string_extension.dart';
import 'package:netinhoappclinica/core/helps/filter.dart';

@injectable
class FilterController {
  List<FamilyPaymnetModel> filter(List<FamilyPaymnetModel> payments, String filter, DateTime actualDate) {
    switch (filter) {
      case FilterStrings.todos:
        return payments;
      case FilterStrings.esteAno:
        return payments.where((p) => p.payDate.year == actualDate.year).toList();
      case FilterStrings.esteMes:
        return payments.where((p) => p.payDate.month == actualDate.month).toList();
      default:
        return payments.where((p) => p.payDate.month == filter.monthToInt).toList();
    }
  }
}
