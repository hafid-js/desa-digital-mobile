import 'package:get/get.dart';

typedef DependencyBuilder<T extends Object> = T Function();

abstract final class Injector {
  static void register<T extends Object>(
    DependencyBuilder<T> builder, {
    bool lazy = false,
    String? tag,
    bool permanent = false,
  }) {
    if (lazy && !permanent) {
      Get.lazyPut<T>(builder, tag: tag);
    } else {
      Get.put<T>(builder(), tag: tag, permanent: permanent);
    }
  }

  static T resolve<T extends Object>({String? tag}) => Get.find<T>(tag: tag);

  static T? maybeResolve<T extends Object>({String? tag}) =>
      Get.isRegistered<T>(tag: tag) ? Get.find<T>(tag: tag) : null;

  static bool isRegistered<T extends Object>({String? tag}) =>
      Get.isRegistered<T>(tag: tag);

  static void unregister<T extends Object>({String? tag}) =>
      Get.delete<T>(tag: tag);
}
