import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_20120598/src/bloc/Lang.dart';
import 'package:mobile_20120598/src/lang/signin.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscured = false;
  String currentMode = "mail";
  String step = "signin";

  final textFieldFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late GoogleSignIn _googleSignIn;

  late SharedPreferences prefs;

  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    await _checkIfIsLogged();
    prefs = await SharedPreferences.getInstance();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      print("is Logged:::: ${accessToken.toJson()}");
    }
  }

  Future<void> _handleSignInFB() async {
    String message = "";
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final token = result.accessToken?.token;
      final data = await authService.loginByFbAuth(token!);
      if (data['success'] == false) {
        message = "Đăng nhập thất bại vui lòng thử lại.";
      } else {
        prefs.setString('access_token', data['tokens']["access"]["token"]);
        prefs.setString('refresh_token', data['tokens']["refresh"]["token"]);
        prefs.setString('user', json.encode(data['user']));
        Navigator.pushNamed(context, '/');
        return;
      }
    } else {
      print(result);
      message = "Đăng nhập thất bại vui lòng thử lại.";
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _handleSignInGG() async {
    String message = "";
    try {
      final response = await _googleSignIn.signIn();
      final googleAuth = await response?.authentication;
      final token = googleAuth?.accessToken;
      final data = await authService.loginByMailAuth(token!);
      if (data['success'] == false) {
        message = "Đăng nhập thất bại vui lòng thử lại.";
      } else {
        prefs.setString('access_token', data['tokens']["access"]["token"]);
        prefs.setString('refresh_token', data['tokens']["refresh"]["token"]);
        prefs.setString('user', json.encode(data['user']));
        Navigator.pushNamed(context, '/');
        return;
      }
    } catch (error) {
      print(error);
      message = "Đăng nhập thất bại vui lòng thử lại.";
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      }
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  void _signin() async {
    String message = "";
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final response = await authService.loginByMail(
          _emailController.text, _passwordController.text);
      if (response['success'] == false) {
        message = "Đăng nhập thất bại vui lòng thử lại.";
      } else {
        prefs.setString('access_token', response['tokens']["access"]["token"]);
        prefs.setString(
            'refresh_token', response['tokens']["refresh"]["token"]);
        Navigator.pushNamed(context, '/');
        return;
      }
    } else {
      message = "Vui lòng nhập email và mật khẩu.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _forgetPassword() async {
    if (step == "confirm") {
      setState(() {
        step = "signin";
      });
    } else {
      setState(() {
        step = "confirm";
      });
    }
    String message = "";
    if (_emailController.text.isEmpty) {
      message = "Bạn phải nhập email.";
    } else {
      final response = await authService.forgetPassword(_emailController.text);
      //handle send email
      if (response['success'] == true) {
        message = "Yêu cầu đặt lại mật khẩu đã được gửi đến email của bạn.";
        step = "confirm";
      } else {
        message = "Đã xẫy ra lỗi vui lòng thử lại sau.";
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalStateCubit, GlobalState>(
      builder: (context, globalState){
        String lang = globalState.lang;
        return MainLayout(
            screen: "signin_page",
            body: Column(
              children: [
                const Image(
                    image: AssetImage("assets/images/sign-in-banner.png"),
                    height: 250),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 40)),
                      Text(signin[lang]!["signin"]!,
                          style: const TextStyle(
                              fontSize: 34, color: Color.fromRGBO(0, 113, 240, 1))),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        signin[lang]!["title"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: currentMode == "mb"
                                ? "0987795761"
                                : "mail@example.com",
                            label: Text(currentMode == "mb"
                                ? signin[lang]!["phone"]!
                                : signin[lang]!["emailAddress"]!)),
                        controller: _emailController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextFormField(
                        obscureText: !_obscured,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            label: Text(signin[lang]!["password"]!),
                            suffixIcon: GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ))),
                        controller: _passwordController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      GestureDetector(
                        onTap: _forgetPassword,
                        child: Text(
                          signin[lang]!["forgotPassword"]!,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      TextButton(
                          onPressed: _signin,
                          style: ButtonStyle(
                              padding: const MaterialStatePropertyAll<EdgeInsets>(
                                  EdgeInsets.only(left: 30, right: 30)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                  const Color.fromRGBO(0, 113, 240, 1))),
                          child: Text(signin[lang]!["signin"]!,
                              style: const TextStyle(color: Colors.white))),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      Text(signin[lang]!["orContinueWith"]!),
                      Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _handleSignInFB,
                                child: SvgPicture.asset("assets/images/fb.svg",
                                    height: 40),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 6, right: 6)),
                              GestureDetector(
                                onTap: _handleSignInGG,
                                child: SvgPicture.asset("assets/images/gg.svg",
                                    height: 40),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 6, right: 6)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (currentMode == "mb") {
                                        currentMode = "mail";
                                      } else {
                                        currentMode = "mb";
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset("assets/images/mb.svg",
                                      height: 40))
                            ],
                          )),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(signin[lang]!["notAccount"]!),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/sign-up");
                            },
                            child: Text(
                              signin[lang]!["signUp"]!,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 80)),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
