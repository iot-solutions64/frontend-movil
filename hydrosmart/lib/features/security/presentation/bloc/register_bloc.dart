import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/security/data/repository/security_repository.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_event.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(
      (event, emit) async {
        emit(RegisterLoading());
        Resource result =
            await SecurityRepository().signUp(event.username, event.password, event.roles);
        if (result is Success) {
          emit(RegisterSuccess());
        } else {
          emit(RegisterError(message: result.message ?? 'Error'));
        }
      },
    );
  }
}