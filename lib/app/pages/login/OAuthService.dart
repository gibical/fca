import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../flavors.dart';

class OAuthService {
  final String clientId = "9ddd87cf-12ac-464b-8fbb-874e88a10b98";
  final String redirectUri = "oauth://mediaverse.global/redirect";
  final String authUrl = '${F.apiurl.substring(0, F.apiurl.lastIndexOf("/") - 2)}oauth/authorize';
  final String tokenUrl = '${F.apiurl.substring(0, F.apiurl.lastIndexOf("/") - 2)}oauth/token';

  Future<String> generateCodeVerifier() async {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final Random random = Random.secure();
    return List.generate(128, (_) => chars[random.nextInt(chars.length)]).join();
  }

  Future<String> generateCodeChallenge(String codeVerifier) async {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  String generateAuthUrl(String codeChallenge) {
    final uri = Uri.parse(authUrl).replace(queryParameters: {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': 'code',
      'scope': '',
      'code_challenge': codeChallenge,
      'code_challenge_method': 'S256',
    });
    return uri.toString();
  }

  Future<Map<String, dynamic>> exchangeCodeForToken(String code, String codeVerifier) async {
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'code': code,
        'redirect_uri': redirectUri,
        'code_verifier': codeVerifier,
      },
    );
    if (response.statusCode == 200) {
      print('OAuthService.exchangeCodeForToken = ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to exchange code for token');
    }
  }

  Future<void> initiateLogin(BuildContext context) async {
    final codeVerifier = await generateCodeVerifier();
    final codeChallenge = await generateCodeChallenge(codeVerifier);
    await GetStorage().write('codeVerifier', codeVerifier);
    final url = generateAuthUrl(codeChallenge);
    final code = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => _OAuthWebView(url),
      ),
    );
    print('OAuthService.initiateLogin = ${code}');
    if (code != null) {
      await getToken(code);
    }
  }

  Future<Map<String, dynamic>> getToken(String code) async {
    final codeVerifier = GetStorage().read<String>('codeVerifier');
    if (codeVerifier == null) {
      throw Exception('Code verifier not found');
    }
    return await exchangeCodeForToken(code, codeVerifier);
  }
}

class _OAuthWebView extends StatefulWidget {
  final String url;
  const _OAuthWebView(this.url);

  @override
  State<_OAuthWebView> createState() => _OAuthWebViewState();
}

class _OAuthWebViewState extends State<_OAuthWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navReq) {
            if (navReq.url.startsWith("oauth://mediaverse.global/redirect")) {
              final uri = Uri.parse(navReq.url);
              final code = uri.queryParameters['code'];
              Navigator.of(context).pop(code);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(

          controller: _controller)),
    );
  }
}
