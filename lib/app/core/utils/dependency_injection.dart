import 'package:dio/dio.dart';
import 'package:gasjm/app/data/providers/authentication_api.dart';
import 'package:gasjm/app/data/repository/authentication_repository.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<Dio>(
        () => Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3')));
    Get.lazyPut<AuthenticationAPI>(() => AuthenticationAPI());
    Get.lazyPut<AuthenticationRepository>(() => AuthenticationRepository());
  }
}
