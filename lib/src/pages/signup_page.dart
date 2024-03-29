import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_20120598/src/bloc/Lang.dart';
import 'package:mobile_20120598/src/lang/signup.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPagePage extends StatefulWidget {
  const SignUpPagePage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPagePage> createState() => _SignUpPagePageState();
}

class _SignUpPagePageState extends State<SignUpPagePage> {
  bool _obscured = false;
  bool _reobscured = false;
  String currentMode = "mail";
  String step = "signup";

  final textFieldFocusNode = FocusNode();
  final retextFieldFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
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
    prefs = await SharedPreferences.getInstance();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
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

  void _retoggleObscured() {
    setState(() {
      _reobscured = !_reobscured;
      if (retextFieldFocusNode.hasPrimaryFocus) {
        return;
      }
      retextFieldFocusNode.canRequestFocus = false;
    });
  }

  void _signup() async {
    String message = "";
    if (step == "confirm") {
      final response = await authService.sendOtpPhone(_otpController.text);
      if (response['success'] == false) {
        message = "Vui lòng kiểm tra lại mã xác nhận của bạn";
      } else {
        prefs.setString('token', response['token']);
        Navigator.pushNamed(context, '/');
        return;
      }
      return;
    }
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _repasswordController.text) {
      final response;
      if (currentMode == "mb") {
        response = await authService.registerByPhone(
            _emailController.text, _emailController.text);
      } else {
        response = await authService.registerByMail(
            _emailController.text, _passwordController.text);
      }
      if (response['success'] == false) {
        message = "Vui lòng kiểm tra lại email và mật khẩu của bạn";
      } else {
        prefs.setString('access_token', response['tokens']["access"]["token"]);
        prefs.setString(
            'refresh_token', response['tokens']["refresh"]["token"]);
        setState(() {
          step = "confirm";
        });

        if (currentMode == "mail") {
          Navigator.pushNamed(context, '/');
        }
        return;
      }
    } else {
      message = "Vui lòng kiểm tra lại email và mật khẩu của bạn.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _handleSignUpGG() async {
    String message = "";
    try {
      final response = await _googleSignIn.signIn();
      final googleAuth = await response?.authentication;
      final token = googleAuth?.accessToken;
      final data = await authService.loginByMailAuth(token!);
      if (data['success'] == false) {
        message = "Vui lòng kiểm tra lại mã xác nhận của bạn";
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

  Future<void> _handleSignInFB() async {
    String message = "";
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final token = result.accessToken?.token;
      final data = await authService.loginByFbAuth(token!);
      if (data['success'] == false) {
        message = "Vui lòng kiểm tra lại mã xác nhận của bạn";
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalStateCubit, GlobalState>(builder: (context, globalState) {
      String lang = globalState.lang;
      return MainLayout(
          screen: "signup_page",
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
                    Text(signup[lang]!["signup"]!,
                        style: const TextStyle(
                            fontSize: 34,
                            color: Color.fromRGBO(0, 113, 240, 1))),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      signup[lang]!["title"]!,
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
                    TextField(
                        enabled: step == "signup",
                        decoration: InputDecoration(
                            hintText: currentMode == "mb"
                                ? "0987795761"
                                : "mail@example.com",
                            label: Text(currentMode == "mb"
                                ? signup[lang]!["phone"]!
                                : signup[lang]!["emailAddress"]!)),
                        controller: _emailController),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TextField(
                      enabled: step == "signup",
                      obscureText: !_obscured,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text(signup[lang]!["password"]!),
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
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TextField(
                      enabled: step == "signup",
                      obscureText: !_reobscured,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text(signup[lang]!["rePassword"]!),
                          suffixIcon: GestureDetector(
                              onTap: _retoggleObscured,
                              child: Icon(
                                _reobscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                              ))),
                      controller: _repasswordController,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: step == "confirm",
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "1234",
                              label: Text(signup[lang]!["confirmCode"]!)),
                          controller: _otpController),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    TextButton(
                        onPressed: _signup,
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.only(left: 30, right: 30)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromRGBO(0, 113, 240, 1))),
                        child: Text(signup[lang]!["signup"]!,
                            style: const TextStyle(color: Colors.white))),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Text(signup[lang]!["orContinueWith"]!),
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
                              onTap: _handleSignUpGG,
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
                        Text(signup[lang]!["notAccount"]!),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/sign-in");
                          },
                          child: Text(
                            signup[lang]!["signin"]!,
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
    });
  }
}
