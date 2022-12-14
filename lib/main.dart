import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pillowtalk/data/repository/friend_repository.dart';
import 'package:pillowtalk/data/repository/user_repository.dart';
import 'package:pillowtalk/data/source/firebase_ds.dart';
import 'package:pillowtalk/presentation/screens/auth/auth_view_model.dart';
import 'package:pillowtalk/presentation/screens/auth/landing_view_model.dart';
import 'package:pillowtalk/presentation/screens/home/home_view_model.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_view_model.dart';
import 'package:pillowtalk/resources/my_router.dart';
import 'package:pillowtalk/resources/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    print('Initialized default app ${app.name}');
  }
  runApp(const MyApp());
}

void setupInjection() {
  getIt.registerLazySingleton<FirebaseDS>(() => FirebaseDS());
  // repositories
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<FriendRepository>(() => FriendRepository());

  // view models
  getIt.registerLazySingleton<LandingViewModel>(() => LandingViewModel(),
      dispose: (vm) { vm.dispose(); }
  );
  getIt.registerLazySingleton<AuthViewModel>(() => AuthViewModel(),
      dispose: (vm) { vm.dispose(); }
  );
  getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel(),
      dispose: (vm) { vm.dispose(); }
  );
  getIt.registerLazySingleton<NewChatViewModel>(() => NewChatViewModel(),
      dispose: (vm) { vm.dispose(); }
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = MyRouter();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pillow Talk',
      theme: MyTheme.getData(),
      darkTheme: MyTheme.getData(isNightMode: true),
      initialRoute: router.initialRoute,
      routes: router.getRoutes(context),
    );
  }
}
