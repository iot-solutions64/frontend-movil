import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/security/data/local/user_model.dart';
import 'package:hydrosmart/features/security/data/repository/security_repository.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_bloc.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_bloc.dart';
import 'package:hydrosmart/features/security/presentation/pages/login_page.dart';
import 'package:hydrosmart/features/security/presentation/pages/signup_page.dart';
import 'package:hydrosmart/features/soil/presentation/pages/crop_detail_page.dart';
import 'package:hydrosmart/features/soil/presentation/pages/crop_history_page.dart';
import 'package:hydrosmart/features/soil/presentation/pages/recommended_actions_page.dart';
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
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => const HomePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/crop_detail') {
            final crop = settings.arguments;
            if (crop != null) {
              return MaterialPageRoute(
                builder: (context) => CropDetailPage(),
                settings: RouteSettings(arguments: crop),
              );
            }
          }
          if (settings.name == '/crop_history') {
            final args = settings.arguments;
            if (args is Map && args['cropId'] is int) {
              return MaterialPageRoute(
                builder: (context) => CropHistoryPage(),
                settings: RouteSettings(arguments: args),
              );
            }
          }
          if (settings.name == '/recommended_actions') {
            final args = settings.arguments;
            if (args is Map && args['id'] is int && args['isHumidity'] is bool) {
              return MaterialPageRoute(
                builder: (context) => RecommendedActionsPage(),
                settings: RouteSettings(arguments: args),
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

