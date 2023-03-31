import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iris_mobile/app/modules/account/modules/payment-methods/controllers/payment_methods_controller.dart';

class PaymentMethodsMobile extends GetView<PaymentMethodsController> {
  const PaymentMethodsMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            controller.updatePaymentMethod(context);
          },
          title: Text(
            'Default Payment Method',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.secondary,
            ),
          ),
          subtitle: Obx(() {
            if (controller.loadingPaymentInfo.value) {
              return Container(
                  alignment: Alignment.bottomLeft,
                  child: const CupertinoActivityIndicator(
                    radius: 8,
                  ));
            } else if (controller.paymentMethodPreview.isEmpty) {
              return const Text(
                "Attach payment method",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              );
            } else {
              return Text(
                controller.paymentMethodPreview,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              );
            }
          }),
          trailing: const Icon(Icons.chevron_right),
        )
      ],
    );
  }
}
