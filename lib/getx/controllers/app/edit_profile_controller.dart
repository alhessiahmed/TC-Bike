import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcbike/api/controllers/user_api_controller.dart';
import 'package:tcbike/model/api_response.dart';
import 'package:tcbike/pref/shared_pref_controller.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController(
      text: SharedPrefController().getByKey(key: UserInfo.name.name));
  final phoneController = TextEditingController(
    text: SharedPrefController().provider == 'phone'
        ? SharedPrefController().getByKey(key: UserInfo.phone.name)
        : SharedPrefController().getByKey(key: UserInfo.email.name),
  );
  final passwordController = TextEditingController(text: '12345678');
  final canClear = false.obs;

  final formKey = GlobalKey<FormState>();
  final passwordVisible = false.obs;
  final isLoading = false.obs;

  XFile? pickedImage;
  bool imageIsUpdated = false;
  late ImagePicker imagePicker = ImagePicker();

  Future<void> pickImageFrom(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(
      source: imageSource,
      imageQuality: 70,
    );
    if (img != null) {
      pickedImage = img;
      imageIsUpdated = true;
      update();
    }
  }

  Future<ApiResponse> updateUserProfile() async {
    final response = await UserApiController().updateUserProfile(
      name: nameController.text,
      imgPath: pickedImage?.path,
    );
    if (response.success) {
      await SharedPrefController().changeName(newName: nameController.text);
      if (response.object != null) {
        await SharedPrefController().changeImage(newImage: response.object);
      }
    }
    return response;
  }
}
