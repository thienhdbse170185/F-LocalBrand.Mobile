import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/features/payment/cubit/payment_cubit.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/screens/widgets/buttons/rounded_elevated_button.dart';
import 'package:f_localbrand/screens/widgets/buttons/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.url});
  final Uri url;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().checkPayment(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          if (state is CheckPaymentInprogress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CheckPaymentSuccess) {
            return Scaffold(
                body: Column(
              children: [
                CustomAppbar(
                  title: 'Status Payment',
                  textTheme: textTheme,
                  hasBack: false,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Payment success! \nThank you for your choosing with us',
                    style: textTheme.displayLarge,
                  ),
                ),
                const SizedBox(height: 25),
                RoundedElevatedButton(
                    onPressed: () {
                      context.go(RouteName.home);
                    },
                    title: 'CONTINUE TO SHOPPING'),
                const SizedBox(height: 10),
                RoundedOutlinedButton(
                    onPressed: () {
                      context.go(RouteName.myOrders);
                    },
                    title: 'TRACKING YOUR ORDER'),
              ],
            ));
          } else {
            return Center(
              child: Text('Error! Cannot check payment'),
            );
          }
        },
      ),
    );
  }
}
