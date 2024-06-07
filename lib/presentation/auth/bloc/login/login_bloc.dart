import 'package:bloc/bloc.dart';
import 'package:flutter_ticketapp/data/models/request/login_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ticketapp/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_ticketapp/data/models/response/login_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDatasource;

  LoginBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      final dataRequest = LoginRequestModel(
        email: event.email,
        password: event.password,
      );

      final response = await authRemoteDatasource.login(dataRequest);

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data)),
      );
    });
  }
}
