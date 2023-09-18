import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Razorpay _razorPay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorPay=Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }
  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: 'Success:${response.paymentId}',toastLength: Toast.LENGTH_SHORT);
  }
  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'Error:'+response.code.toString(),toastLength: Toast.LENGTH_SHORT);
  }
  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'External Wallet:${response.walletName}',toastLength: Toast.LENGTH_SHORT);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorPay.clear();
  }
  void openPayment()async{
    var options={
      'key':'rzp_test_NC68BJj8wKuMXw',
      'key Secret':'b51bGyiRV4AlWBn7YL99dzPR',
      'amount':100*100,
      'name':'hotel',
      'description':'Meals',
      'retry':{'enabled':true,'max_count':1},
      'prefil':{'contact':'7306413956','email':'hotel@gmail.com'},
      'external':{'wallets':['paytm','gpay',]},
    };
    try {
      _razorPay.open(options);
    } catch (e) {
      debugPrint('error : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(onPressed:
          openPayment, 
          icon: Text('Pay')),
      ),
    );
  }
}