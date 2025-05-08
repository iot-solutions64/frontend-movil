import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/security/data/repository/security_repository.dart';
import 'package:hydrosmart/features/security/domain/user.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_event.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(
      (event, emit) async {
        emit(LoginLoading());
        Resource<User> result =
            await SecurityRepository().login(event.username, event.password);
        if (result is Success) {
          emit(LoginSuccess());
        } else {
          emit(LoginError(message: result.message ?? 'Error'));
        }
      },
    );
  }
}