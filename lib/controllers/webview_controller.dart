import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewControllerX extends GetxController {
  late final WebViewController controller;
  RxInt loadingpercentage = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void WebViewFunc(String url) {
    controller = WebViewController()
      ..loadRequest(Uri.parse(url)) // Load the URL
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          loadingpercentage.value = 0;
        },
        onProgress: (progress) {
          loadingpercentage.value = progress;
        },
        onPageFinished: (url) {
          loadingpercentage.value = 100;
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("Snackbar", onMessageReceived: (message) {
        Get.snackbar("Snackbar", message.message);
      });
  }
}
