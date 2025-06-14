import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/irrigation/presentation/pages/tanks_page.dart';
import 'package:hydrosmart/features/irrigation/presentation/pages/water_graph_page.dart';
import 'package:hydrosmart/features/security/data/local/user_model.dart';
import 'package:hydrosmart/features/security/data/repository/security_repository.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_bloc.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_bloc.dart';
import 'package:hydrosmart/features/security/presentation/pages/login_page.dart';
import 'package:hydrosmart/features/security/presentation/pages/signup_page.dart';
import 'package:hydrosmart/features/soil/presentation/pages/crop_detail_page.dart';
import 'package:hydrosmart/features/soil/presentation/pages/crop_history_page.dart';
import 'package:hydrosmart/features/soil/presentation/pages/recommended_actions_page.dart';
import 'package:hydrosmart/features/system/domain/system.dart';
import 'package:hydrosmart/features/system/presentation/pages/add_system_page.dart';
import 'package:hydrosmart/features/system/presentation/pages/system_detail_page.dart';
import 'package:hydrosmart/features/system/presentation/pages/system_edit_page.dart';
import 'package:hydrosmart/shared/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Resource<UserModel> user = await SecurityRepository().getUser();
  bool isLoggedIn = user is Success && user.data != null;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? '/home' : '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
          '/tanks': (context) => const TanksPage(),
          '/water_graph': (context) => const WaterGraphPage(),
          '/add_system': (context) => const AddSystemPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/crop_detail') {
            final crop = settings.arguments;
            if (crop != null) {
              return MaterialPageRoute(
                builder: (context) => const CropDetailPage(),
                settings: RouteSettings(arguments: crop),
              );
            }
          }
          if (settings.name == '/crop_history') {
            final args = settings.arguments;
            if (args is Map && args['cropId'] is int) {
              return MaterialPageRoute(
                builder: (context) => const CropHistoryPage(),
                settings: RouteSettings(arguments: args),
              );
            }
          }
          if (settings.name == '/recommended_actions') {
            final args = settings.arguments;
            if (args is Map && args['id'] is int && args['isHumidity'] is bool) {
              return MaterialPageRoute(
                builder: (context) => const RecommendedActionsPage(),
                settings: RouteSettings(arguments: args),
              );
            }
          }
          if (settings.name == '/system_detail') {
            final system = settings.arguments;
            if (system is System) {
              return MaterialPageRoute(
                builder: (context) => SystemDetailPage(system: system),
                settings: RouteSettings(arguments: system),
              );
            }
          }
          if (settings.name == '/system_edit') {
            final system = settings.arguments;
            if (system is System) {
              return MaterialPageRoute(
                builder: (context) => SystemEditPage(system: system),
                settings: RouteSettings(arguments: system),
              );
            }
          }
          // fallback
          return null;
        },
      ),
    );
  }
}

