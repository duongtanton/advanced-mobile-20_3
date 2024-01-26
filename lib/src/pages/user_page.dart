import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/user_service.dart';
import 'package:mobile_20120598/src/util/common_util.dart';
import 'dart:io';
import 'dart:async';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.title});

  final String title;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserService _userService = UserService();

  var user = null;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _scheduleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserInfo();
    });
  }

  void _getUserInfo() async {
    final response = await _userService.getCurrentInfo();
    if (response['success']) {
      setState(() {
        user = response['data'];
        _nameController.text = user['name'] ?? '';
        _emailController.text = user['email'] ?? '';
        _countryController.text =user!['country'] ?? '';
        _phoneController.text = user['phone'] ?? '';
        _dobController.text = user['birthday'] ?? '';
        _educationController.text = user['level'] ?? '';
        _courseController.text = user['learnTopics']
                ?.map((item) => item['name'])
                ?.toList()
                .join(',') ??
            '';
        _scheduleController.text = user['studySchedule'] ?? '';
      });
    }
  }

  void _updateUserProfile() async {
    final response = await _userService.updateProfile(
      name: _nameController.text,
      phone: _phoneController.text,
    );
    if (response['success']) {
      setState(() {
        user = response['data'];
        _nameController.text = user['name'] ?? '';
        _emailController.text = user['email'] ?? '';
        _countryController.text = user!['country'] ?? '';
        _phoneController.text = user['phone'] ?? '';
        _dobController.text = user['birthday'] ?? '';
        _educationController.text = user['level'] ?? '';
        _courseController.text = user['learnTopics']
                ?.map((item) => item['name'])
                ?.toList()
                .join(',') ??
            '';
        _scheduleController.text = user['studySchedule'] ?? '';
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? files = await picker.pickImage(source: ImageSource.gallery);
    if (files != null) {
      dynamic response  = await _userService.updateAvatar(File(files.path));
      if (response['success']) {
        setState(() {
          user = response['data'];
        });
      }
    } else {
      print('No image selected.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MainLayout(
        screen: "user",
        showNavigators: true,
        body: user == null
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Implement your logic to change avatar here
                            _getImageFromGallery();
                            print("Change avatar");
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(user["avatar"],
                                height: 90, width: 90, fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/images/teacher.jpg",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  );
                                }),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user["name"] ?? "",
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 6)),
                            Wrap(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: user["id"],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 6)),
                            Row(
                                children: CommonUtil.renderStars(
                                    user["avgRating"] ?? 5, 5, 18)),
                            const Padding(padding: EdgeInsets.only(top: 6)),
                            Row(
                              children: [
                                CountryFlag.fromCountryCode(
                                  user['country'] ?? "VN",
                                  height: 26,
                                  width: 30,
                                  borderRadius: 8,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 10)),
                                Text(CommonConstant
                                        .countryMap[user['country']] ??
                                    "")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      enabled: false,
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _countryController,
                      decoration: InputDecoration(labelText: 'Country'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      enabled: false,
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _dobController,
                      decoration: InputDecoration(labelText: 'Date of Birth'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _educationController,
                      decoration: InputDecoration(labelText: 'Education Level'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _courseController,
                      decoration: InputDecoration(labelText: 'Desired Course'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      maxLines: 2,
                      controller: _scheduleController,
                      decoration: InputDecoration(labelText: 'Study Schedule'),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        // Implement your logic to update user profile here
                        _updateUserProfile();
                      },
                      child: Text('Update Profile'),
                    ),
                  ],
                )));
  }
}
