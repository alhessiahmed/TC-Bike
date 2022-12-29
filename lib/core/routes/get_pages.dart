import 'package:get/get.dart';
import 'package:tcbike/getx/bindings/app/category_binding.dart';
import 'package:tcbike/getx/bindings/app/contact_us_binding.dart';
import 'package:tcbike/getx/bindings/app/favorite_binding.dart';
import 'package:tcbike/getx/bindings/app/payment_binding.dart';
import 'package:tcbike/getx/bindings/app/product_details_binding.dart';
import 'package:tcbike/getx/bindings/app/settings_binding.dart';
import 'package:tcbike/getx/bindings/auth/change_password_binding.dart';
import 'package:tcbike/screens/app/profile/about_us_screen.dart';
import 'package:tcbike/screens/app/search_screen.dart';
import 'package:tcbike/screens/auth/change_password_screen.dart';
import '../../getx/bindings/app/search_binding.dart';
import '../../screens/app/profile/favorite_screen.dart';
import '../../screens/app/profile/notifications_screen.dart';
import '../../screens/app/profile/order/order_screen.dart';
import '../../screens/app/profile/order/order_success_screen.dart';
import '../../screens/app/profile/settings/contact_us_screen.dart';
import '../../screens/app/profile/settings/privacy_policy_screen.dart';
import '../../screens/app/profile/settings/settings_screen.dart';
import 'package:tcbike/screens/app/payment_screen.dart';
import 'package:tcbike/screens/app/product_details_screen.dart';
import 'package:tcbike/screens/app/profile/edit_profile_screen.dart';
import '../../getx/bindings/app/edit_profile_binding.dart';
import '../../getx/bindings/auth/verification_binding.dart';
import '../../screens/app/profile/settings/support_center_screen.dart';
import '../../screens/auth/verification_screen.dart';
import '../../screens/auth/terms_conditions_screen.dart';
import '../../screens/intro/onboarding_screen.dart';
import '../../core/routes/routes_manager.dart';
import '../../getx/bindings/app/home_binding.dart';
import '../../getx/bindings/auth/reset_password_binding.dart';
import '../../getx/bindings/auth/forget_password_binding.dart';
import '../../getx/bindings/auth/sign_in_binding.dart';
import '../../getx/bindings/auth/sign_up_binding.dart';
import '../../screens/auth/reset_password_screen.dart';
import '../../screens/auth/forget_password_screen.dart';
import '../../screens/auth/sign_in_screen.dart';
import '../../screens/auth/sign_up_screen.dart';
import '../../screens/intro/launch_screen.dart';
import '../../screens/app/home_screen.dart';

final List<GetPage<dynamic>> getPages = [
  // Intro
  GetPage(
    name: RoutesManager.launchScreen,
    page: () => const LaunchScreen(),
  ),
  GetPage(
    name: RoutesManager.onboardingScreen,
    page: () => const OnboardingScreen(),
  ),
  // Auth
  GetPage(
    name: RoutesManager.signInScreen,
    page: () => const SignInScreen(),
    binding: SignInBinding(),
  ),
  GetPage(
    name: RoutesManager.signUpScreen,
    page: () => const SignUpScreen(),
    binding: SignUpBinding(),
  ),
  GetPage(
    name: RoutesManager.termsConditionsScreen,
    page: () => const TermsConditionsScreen(),
  ),
  GetPage(
    name: RoutesManager.forgetPasswordScreen,
    page: () => const ForgetPasswordScreen(),
    binding: ForgetPasswordBinding(),
  ),
  GetPage(
    name: RoutesManager.resetPasswordScreen,
    page: () => const ResetPasswordScreen(),
    binding: ResetPasswordBinding(),
  ),
  GetPage(
    name: RoutesManager.changePasswordScreen,
    page: () => const ChangePasswordScreen(),
    binding: ChangePasswordBinding(),
  ),
  GetPage(
    name: RoutesManager.verificationScreen,
    page: () => const VerificationScreen(),
    binding: VerificationBinding(),
  ),
  GetPage(
    name: RoutesManager.homeScreen,
    page: () => const HomeScreen(),
    bindings: [
      HomeBinding(),
      CategoryBinding(),
    ],
  ),
  GetPage(
    name: RoutesManager.searchScreen,
    page: () => const SearchScreen(),
    binding: SearchBinding(),
  ),
  GetPage(
    name: RoutesManager.productDetailsScreen,
    page: () => const ProductDetailsScreen(),
    binding: ProductDetailsBinding(),
  ),
  GetPage(
    name: RoutesManager.paymentScreen,
    page: () => const PaymentScreen(),
    binding: PaymentBinding(),
    transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: RoutesManager.editProfileScreen,
    page: () => const EditProfileScreen(),
    binding: EditProfileBinding(),
  ),
  GetPage(
    name: RoutesManager.settingsScreen,
    page: () => const SettingsScreen(),
    binding: SettingsBinding(),
  ),
  GetPage(
    name: RoutesManager.privacyPolicyScreen,
    page: () => const PrivacyPolicyScreen(),
  ),
  GetPage(
    name: RoutesManager.contactUsScreen,
    page: () => const ContactUsScreen(),
    binding: ContactUsBinding(),
  ),
  GetPage(
    name: RoutesManager.supportCenterScreen,
    page: () => const SupportCenterScreen(),
  ),
  GetPage(
    name: RoutesManager.notificationsScreen,
    page: () => const NotificationsScreen(),
  ),
  GetPage(
    name: RoutesManager.favoriteScreen,
    page: () => const FavoriteScreen(),
    binding: FavoriteBinding(),
  ),
  GetPage(
    name: RoutesManager.aboutUsScreen,
    page: () => const AboutUsScreen(),
  ),
  GetPage(
    name: RoutesManager.orderScreen,
    page: () => const OrderScreen(),
  ),
  GetPage(
    name: RoutesManager.orderSuccessScreen,
    page: () => const OrderSuccessScreen(),
  ),
];
