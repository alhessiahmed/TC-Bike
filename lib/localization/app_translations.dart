import 'package:get/get.dart';
import 'ar.dart';
import 'he.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': arLocale,
        'he': heLocale,
      };
}
