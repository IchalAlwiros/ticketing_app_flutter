import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ticketapp/core/core.dart';
import 'package:flutter_ticketapp/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_ticketapp/presentation/auth/splash_page.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                context.pushReplacement(const SplashPage());
              },
              error: (error) {
                // showSnackBarFun(context) {
                //   SnackBar snackBar = SnackBar(
                //     content: Text(
                //       error,
                //       style: const TextStyle(fontSize: 20),
                //     ),
                //     backgroundColor: Colors.indigo,
                //     dismissDirection: DismissDirection.up,
                //     behavior: SnackBarBehavior.floating,
                //     margin: EdgeInsets.only(
                //         bottom: MediaQuery.of(context).size.height - 150,
                //         left: 10,
                //         right: 10),
                //   );

                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // }

                context.showErrorSnackbar(error);
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(
                //       SnackBar(
                //         content: Row(
                //           children: [
                //             const Icon(Icons.info, color: AppColors.white),
                //             const SizedBox(width: 2),
                //             Text(
                //               error,
                //               style: const TextStyle(fontSize: 20),
                //             ),
                //           ],
                //         ),
                //         duration: const Duration(milliseconds: 800),
                //         backgroundColor: AppColors.error,
                //         dismissDirection: DismissDirection.up,
                //         behavior: SnackBarBehavior.floating,
                //       ),
                //     )
                //     .closed
                //     .then((value) =>
                //         ScaffoldMessenger.of(context).clearSnackBars());

                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Row(
                //       children: [
                //         const Icon(Icons.info, color: AppColors.white),
                //         const SizedBox(width: 2),
                //         Text(
                //           error,
                //           style: const TextStyle(fontSize: 20),
                //         ),
                //       ],
                //     ),
                //     duration: const Duration(milliseconds: 800),
                //     backgroundColor: AppColors.error,
                //     dismissDirection: DismissDirection.up,
                //     behavior: SnackBarBehavior.floating,
                //   ),
                // );
              },
            );
          },
          child: BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return ElevatedButton(
                  onPressed: () async {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                    // context.pushReplacement(const SplashPage());
                  },
                  child: const Text('Logout'),
                );
              }, loading: () {
                return const CircularProgressIndicator();
              });
            },
          ),
        ),
      ),
    );
  }
}
