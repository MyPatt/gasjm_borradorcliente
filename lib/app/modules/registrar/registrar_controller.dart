import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class RegistrarController extends GetxController {
  /* final _authRepository = Get.find<AuthenticationRepository>();
  final _authStorage = Get.find<AuthStorageRepository>();

  RequestToken _oRequestToken = RequestToken();
  RequestToken get oRequestToken => _oRequestToken;
*/
  RxBool _isOscure1 = true.obs;
  RxBool get isOscure1 => _isOscure1;

  RxBool _isOscure2 = true.obs;
  RxBool get isOscure2 => _isOscure2;
  /* String _email = "";
  String _password = ""; */
  String _email = "gqcrispin@gmail.com";
  String _password = "123456";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onChangedEmail(String value) {
    print(value);
    _email = value;
  }

  void onChangedPassword(String value) {
    print(value);
    _password = value;
  }

  void mostrarContrasena() {
    _isOscure1.value = _isOscure1.value ? false : true;
  }

  void mostrarConfirmacionContrasena() {
    _isOscure2.value = _isOscure2.value ? false : true;
  }

  cargarLogin() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      Get.toNamed(AppRoutes.login);
    } catch (e) {
      print(e);
    }
  }

  auth() async {
    /*  try {
      _oRequestToken = await _authRepository.authentication(
        email: _email,
        password: _password,
      );

      //Guardar datos en storage
      _authStorage.setSession(requestToken: _oRequestToken);

      if (_oRequestToken.success) {
        Get.offNamed(AppRoutes.HOME, arguments: _oRequestToken.requestToken);
      }
    } on DioError catch (e) {
      Get.snackbar(
        'Message',
        e.response.data["message"],
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.blueBackground,
      );
    }*/
  }

  loadHome() {
    // Get.toNamed(AppRoutes.HOME);
    //
  }
}
