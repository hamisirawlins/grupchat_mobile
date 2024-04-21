import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository extends GetxController {
  //Supabase instance
  final supabase = Supabase.instance.client;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
  }
}
