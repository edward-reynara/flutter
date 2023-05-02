
import 'package:inject/inject.dart';
import 'modules/PreferenceModule.dart';
import 'app_component.inject.dart' as g;

@Injector(const [PreferenceModule])
abstract class AppComponent {
  static Future<AppComponent> create(PreferenceModule preferenceModule) async {
    return await g.AppComponent$Injector.create(preferenceModule);
  }
}
