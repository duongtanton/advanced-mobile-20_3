import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.login});

  final bool login;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              GestureDetector(
                onTap: () => Navigator.popAndPushNamed(context, "/"),
                child: SvgPicture.asset("assets/images/logo.svg", width: 180),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => {},
                      icon: SvgPicture.asset("assets/images/vi.svg")),
                  if (login)
                    IconButton(
                        onPressed: () => {},
                        icon: Image.asset("assets/images/setting.png"))
                ],
              )
            ],
          )),
    );
  }
}
