import 'package:get/state_manager.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';

class SettingsController extends GetxController {
  final enableNotifications = true.obs;
  final isArabic = (SharedPrefController().lang == 'ar').obs;
}
