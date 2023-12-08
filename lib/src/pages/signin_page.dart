import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_20120598/src/components/header.dart';
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

  final textFieldFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late GoogleSignIn _googleSignIn;

  AccessToken? _accessToken;

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
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
    }
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
        Navigator.popAndPushNamed(context, '/');
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
        message = "Vui lòng kiểm tra lại mã xác nhận của bạn";
      } else {
        prefs.setString('access_token', data['tokens']["access"]["token"]);
        prefs.setString('refresh_token', data['tokens']["refresh"]["token"]);
        prefs.setString('user', json.encode(data['user']));
        Navigator.popAndPushNamed(context, '/');
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
        Navigator.popAndPushNamed(context, '/');
        return;
      }
    } else {
      message = "Vui lòng nhập email và mật khẩu.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _forgetPassword() {
    String message = "";
    if (_emailController.text.isEmpty) {
      message = "Bạn phải nhập email.";
    } else {
      //handle send email
      message = "Yêu cầu đặt lại mật khẩu đã được gửi đến email của bạn.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(login: false),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                    image: AssetImage("assets/images/sign-in-banner.png"),
                    height: 250),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Text("Đăng nhập",
                          style: TextStyle(
                              fontSize: 34,
                              color: Color.fromRGBO(0, 113, 240, 1))),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        "Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 "
                        "kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                                ? "SỐ ĐIỆN THOẠI"
                                : "ĐỊA CHỈ EMAIL")),
                        controller: _emailController,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextFormField(
                        obscureText: !_obscured,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            label: const Text("MẬT KHẨU"),
                            suffixIcon: GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ))),
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.length < 9) {
                            return 'Phone number must be 9 digits or longer';
                          }
                          return null;
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      GestureDetector(
                        onTap: _forgetPassword,
                        child: const Text(
                          "Quên mật khẩu?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      TextButton(
                          onPressed: _signin,
                          style: ButtonStyle(
                              padding:
                                  const MaterialStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.only(left: 30, right: 30)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromRGBO(0, 113, 240, 1))),
                          child: const Text("ĐĂNG NHẬP",
                              style: TextStyle(color: Colors.white))),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      const Text("Hoặc tiếp tục với"),
                      Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _handleSignInFB();
                                  currentMode = "fb";
                                },
                                child: SvgPicture.asset("assets/images/fb.svg",
                                    height: 40),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 6, right: 6)),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentMode = "gg";
                                  });
                                  _handleSignInGG();
                                },
                                child: SvgPicture.asset("assets/images/gg.svg",
                                    height: 40),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(left: 6, right: 6)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentMode = "mb";
                                    });
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/mb.svg",
                                      height: 40))
                            ],
                          )),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Bạn chưa có tài khoản? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, "/sign-up");
                            },
                            child: const Text(
                              "Đăng ký",
                              style: TextStyle(
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
            ),
          ))
        ],
      ),
    );
  }
}
