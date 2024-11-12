import 'package:flutter_modular/flutter_modular.dart';

import 'common/keys.dart';
import 'data/data.dart';

class MainModule extends Module {
  MainModule({
    required this.applicationDocumentDirectory,
    required this.databaseFilename,
  });

  String applicationDocumentDirectory;
  String databaseFilename;

  @override
  List<Module> get imports => [
        IsarDataRepositoryModule(
          applicationDocumentDirectory,
          databaseFilename,
        ),
      ];

  @override
  void binds(Injector i) {
    i.addInstance(
      applicationDocumentDirectory,
      key: pkAppDirectory,
    );
    i.addInstance(
      databaseFilename,
      key: pkDbFile,
    );
  }

  @override
  void routes(RouteManager r) {
    // r.child(NavigationEntries.splashScreen,
    //     child: (context) => const SplashScreen());
    // r.child(NavigationEntries.home, child: (context) => const HomePage());
  }
}
