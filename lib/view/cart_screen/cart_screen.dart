import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_app_ui/controller/cartscreencontroller.dart';
import 'package:shopping_app_ui/view/cart_screen/card/card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Cartscreencontroller>().getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<Cartscreencontroller>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: cartController.cartItems.isNotEmpty
          ? ListView.separated(
              itemBuilder: (context, index) {
                return CardWidget(cartItem: cartController.cartItems[index],index: index,);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: cartController.cartItems.length,
            )
          : const Center(
              child: Text("Your cart is empty"),
            ),

             bottomNavigationBar: Container(
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  Text("Total Amount:"),
                  Text(cartController.totalcartprice.toString()),
                  SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: (){
                  Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_live_ILgsfZCZoFIKMb',
                    'amount': cartController.totalcartprice * 100,
                    'name': 'Acme Corp.',
                    'description': 'Fine T-Shirt',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                  razorpay.open(options);
                },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        
                      ),
                      child: Center(child: Text("checkout",style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ),
             ),
    );
  }
   void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
