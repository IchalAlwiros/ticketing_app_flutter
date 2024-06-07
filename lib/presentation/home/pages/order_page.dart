import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ticketapp/core/core.dart';
import 'package:flutter_ticketapp/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_ticketapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_ticketapp/presentation/home/pages/order_detail_page.dart';
import 'package:flutter_ticketapp/presentation/home/widgets/order_card.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Ticket'),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (error) {
              context.showErrorSnackbar(error);
            },
            // initial: () {
            //   context
            //       .read<ProductBloc>()
            //       .add(const ProductEvent.getProduct(1, 5));
            // },
            orElse: () {},
          );
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            // context
            //     .read<ProductBloc>()
            //     .add(const ProductEvent.getLocalProducts());
            // context.read<ProductBloc>().add(const ProductEvent.getProduct(1, 5));

            // state.maybeWhen(
            //   initial: () => context
            //       .read<ProductBloc>()
            //       .add(const ProductEvent.getProduct(1, 5)),
            //   orElse: () => [],
            // );

            // final products = state.maybeWhen(
            //   // initial: () => context
            //   //     .read<ProductBloc>()
            //   //     .add(const ProductEvent.getProduct(1, 5)),
            //   success: (products) => products,
            //   orElse: () => [],
            // );
            // if (products.isEmpty) {
            //   return const Center(
            //     child: Text('No Data'),
            //   );
            // }
            // return ListView.separated(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   itemCount: products.length,
            //   separatorBuilder: (context, index) => const SpaceHeight(20.0),
            //   itemBuilder: (context, index) => OrderCard(
            //     item: products[index],
            //   ),
            // );

            return state.maybeWhen(
                initial: () {
                  context
                      .read<ProductBloc>()
                      .add(const ProductEvent.getProduct(1, 5));
                  return const SizedBox();
                },
                // error: (error) {
                //   context.showErrorSnackbar(error);
                //   return const SizedBox();
                // },
                success: (products) => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: products.length,
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(20.0),
                      itemBuilder: (context, index) => OrderCard(
                        item: products[index],
                      ),
                    ),
                orElse: () {
                  return const Center(
                    child: Text('No Data'),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Order Summary'),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        success: (checkout) {
                          final total = checkout.fold<int>(
                            0,
                            (previousValue, element) =>
                                previousValue +
                                element.product.price! * element.quantity,
                          );
                          return Text(
                            total.currencyFormatRp,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          );
                        },
                        orElse: () => const Text(
                          '0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      );
                      // return Text(
                      //   40000.currencyFormatRp,
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16.0,
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    success: (products) {
                      return Button.filled(
                        height: 48,
                        width: 120,
                        disabled: products.isEmpty,
                        onPressed: () {
                          context.push(const OrderDetailPage());
                        },
                        label: 'Process',
                      );
                    },
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
