import 'package:get/instance_manager.dart';
import '../controllers/contacts_permission_controller.dart';

class ContactsPermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactsPermissionController());
  }
}
