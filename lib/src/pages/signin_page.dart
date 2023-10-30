import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                    image: AssetImage("assets/images/sign-in-banner.png")),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Column(
                    children: [
                      Text("Đăng nhập",
                          style: TextStyle(
                              fontSize: 44,
                              color: Color.fromRGBO(0, 113, 240, 1))),
                      Text(
                        "Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 " +
                            "kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
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

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black54,
            blurRadius: 15.0,
            offset: Offset(0.0, 0.75) // changes position of shadow
            ),
      ], color: Colors.white),
      child: Container(
          padding: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/images/logo.svg", width: 180),
              IconButton(
                  onPressed: () => {},
                  icon: SvgPicture.asset("assets/images/vi.svg"))
            ],
          )),
    );
  }
}
