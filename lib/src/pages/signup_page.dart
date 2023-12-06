import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_20120598/src/components/header.dart';
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

  late SharedPreferences prefs;

  AuthService authService = AuthService();

  @override
  void initState() async {
    super.initState();
    prefs = await SharedPreferences.getInstance();
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
        Navigator.popAndPushNamed(context, '/');
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
            _emailController.text, _emailController.text);
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
          Navigator.popAndPushNamed(context, '/');
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
                      Text("Đăng ký",
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
                      TextField(
                          enabled: step == "signup",
                          decoration: InputDecoration(
                              hintText: currentMode == "mb"
                                  ? "0987795761"
                                  : "mail@example.com",
                              label: Text(currentMode == "mb"
                                  ? "SỐ ĐIỆN THOẠI"
                                  : "ĐỊA CHỈ EMAIL")),
                          controller: _emailController),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextField(
                        enabled: step == "signup",
                        obscureText: _obscured,
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
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextField(
                        enabled: step == "signup",
                        obscureText: _reobscured,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            label: const Text("NHẬP LẠI MẬT KHẨU"),
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
                            decoration: const InputDecoration(
                                hintText: "1234", label: Text("MÃ XÁC NHẬN")),
                            controller: _otpController),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      TextButton(
                          onPressed: _signup,
                          style: ButtonStyle(
                              padding:
                                  const MaterialStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.only(left: 30, right: 30)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromRGBO(0, 113, 240, 1))),
                          child: const Text("ĐĂNG KÝ",
                              style: TextStyle(color: Colors.white))),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      const Text("Hoặc đăng ký với"),
                      Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentMode = "fb";
                                  });
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
                          Text("Bạn đã có tài khoản? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(context, "/sign-in");
                            },
                            child: const Text(
                              "Đăng nhập",
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
