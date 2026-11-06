import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  static const String _razorpayKey = 'rzp_test_Tmz7hzH9d4AGe5';
  // static const String _razorpayKey = 'rzp_live_SH7mzqHtTrpT1V';

  late Razorpay _razorpay;

  void init({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout({
    required String orderId,
    required int amount,
    required String name,
    required String description,
    required String email,
  }) {
    final int amountInPaise = amount * 100;

    debugPrint(
      "My order id is: order_$orderId and amount is: $amountInPaise paise",
    );

    final options = {
      'key': _razorpayKey,
      "currency": "INR",
      'amount': amountInPaise,
      'name': name,
      'description': description,
      'prefill': {'email': email},
      'theme': {'color': '#5B2EFF'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log('Razorpay Open Error: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
