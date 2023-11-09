import 'package:clisp/app/pages/avaliacoes/domain/model/avaliation.dart';
import 'package:injectable/injectable.dart';
import 'package:clisp/app/pages/grupo_familiar/domain/model/family_payment_model.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/helps/filter.dart';

@injectable
class FilterController {
  List<FamilyPaymnetModel> filterPayments(List<FamilyPaymnetModel> payments, String filter, DateTime actualDate) {
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
  List<Avaliation> filterAvaliations(List<Avaliation> avaliations, String filter, DateTime actualDate) {
    switch (filter) {
      case FilterStrings.todos:
        return avaliations;
      case FilterStrings.esteAno:
        return avaliations.where((p) => p.data.toDateTime.year == actualDate.year).toList();
      case FilterStrings.esteMes:
        return avaliations.where((p) => p.data.toDateTime.month == actualDate.month).toList();
      default:
        return avaliations.where((p) => p.data.toDateTime.month == filter.monthToInt).toList();
    }
  }
}
