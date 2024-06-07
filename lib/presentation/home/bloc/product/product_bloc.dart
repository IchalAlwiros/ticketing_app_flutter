import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ticketapp/data/datasource/product_remote_datasource.dart';
import 'package:flutter_ticketapp/data/models/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;

  ProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetProduct>((event, emit) async {
      emit(const _Loading());
      final response = await _productRemoteDatasource.getProducts(
        page: event.page,
        limit: event.limit,
      );

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data.data ?? [])),
      );
    });
  }
}
