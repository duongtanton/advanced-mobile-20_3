import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_20120598/src/components/header.dart';

class SignUpPagePage extends StatefulWidget {
  const SignUpPagePage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPagePage> createState() => _SignUpPagePageState();
}

class _SignUpPagePageState extends State<SignUpPagePage> {
  bool _obscured = false;
  bool _reobscured = false;

  final textFieldFocusNode = FocusNode();
  final retextFieldFocusNode = FocusNode();

  String email = "";
  String password = "";
  String repassword = "";

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

  void _signup() {
    String message = "";
    if (email.isNotEmpty && password.isNotEmpty && password == repassword) {
      message = "Đăng ký thành công vui lòng kiểm tra lại email của bạn";
    } else {
      message = "Đã sảy ra lỗi vui lòng thử lại";
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
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 40),
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                                hintText: "mail@example.com",
                                label: Text("ĐỊA CHỈ EMAIL")),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          TextField(
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
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          TextField(
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
                            onChanged: (value) {
                              setState(() {
                                repassword = value;
                              });
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          TextButton(
                              onPressed: _signup,
                              style: ButtonStyle(
                                  padding:
                                  const MaterialStatePropertyAll<EdgeInsets>(
                                      EdgeInsets.only(left: 30, right: 30)),
                                  backgroundColor: MaterialStateColor
                                      .resolveWith(
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
                                  SvgPicture.asset("assets/images/fb.svg",
                                      height: 40),
                                  const Padding(
                                      padding: EdgeInsets.only(
                                          left: 6, right: 6)),
                                  SvgPicture.asset("assets/images/gg.svg",
                                      height: 40),
                                  const Padding(
                                      padding: EdgeInsets.only(
                                          left: 6, right: 6)),
                                  SvgPicture.asset("assets/images/mb.svg",
                                      height: 40)
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
