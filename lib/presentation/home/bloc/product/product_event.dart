part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.getProduct(int page, int limit) = _GetProduct;
  const factory ProductEvent.syncProduct() = _SyncProduct;
  const factory ProductEvent.getLocalProducts() = _GetLocalProducts;
}
