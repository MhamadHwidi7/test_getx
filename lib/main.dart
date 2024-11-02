import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_test/app_binding.dart';
import 'package:ecommerce_test/core/routes/routes.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const App());
}
class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MH-TEST',
      getPages: Routes.routes,
      initialRoute: Routes.INITIAL,
      initialBinding: AppBinding(),
      
    );
  }

}
