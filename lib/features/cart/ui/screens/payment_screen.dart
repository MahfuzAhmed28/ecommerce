import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentAmount});

  static const String name='/payment-screen';

  final double paymentAmount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _webViewController;

  // On success
  void _placeOrder(){}
  // On failure
  void _showDialogue(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Payment failed'),
        content: Column(
          children: [
            Text('Your payment has been failed. Please try again!')
          ],
        ),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: Text('Okay'))
        ],
      );
    });
  }
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print(request.url);
            // On success/fail we will redirect to the cart screen
            if (request.url.startsWith('success-url')) {
              _placeOrder();
            }
            else if(request.url.startsWith('failed-url')){
              _showDialogue();
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev?payment-amount=${widget.paymentAmount}'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
