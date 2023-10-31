import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_20120598/src/components/header.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscured = false;

  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      }
      textFieldFocusNode.canRequestFocus = false;
    });
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
                      const TextField(
                        decoration: InputDecoration(
                            hintText: "mail@example.com",
                            label: Text("ĐỊA CHỈ EMAIL")),
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
                      ),
                      const Padding(padding: EdgeInsets.only(top: 50)),
                      const Text("Quên mật khẩu?", textAlign: TextAlign.start),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      TextButton(
                          onPressed: () => {Navigator.pushNamed(context, '/')},
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
                              SvgPicture.asset("assets/images/fb.svg",
                                  height: 40),
                              const Padding(
                                  padding: EdgeInsets.only(left: 6, right: 6)),
                              SvgPicture.asset("assets/images/gg.svg",
                                  height: 40),
                              const Padding(
                                  padding: EdgeInsets.only(left: 6, right: 6)),
                              SvgPicture.asset("assets/images/mb.svg",
                                  height: 40)
                            ],
                          )),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Bạn chưa có tài khoản? "),
                          Text(
                            "Đăng ký",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
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
