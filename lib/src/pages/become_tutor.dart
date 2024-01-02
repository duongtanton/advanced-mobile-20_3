import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/user_service.dart';

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({super.key, required this.title});

  final String title;

  @override
  State<BecomeTutorPage> createState() => _BecomeTutorPageState();
}

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  final UserService _userService = UserService();
  int _currentStep = 0;
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
        _countryController.text =
            CommonConstant.countryMap[user?['country']] ?? '';
        _phoneController.text = user['phone'] ?? '';
        _dobController.text = user['birthday'] ?? '';
        _educationController.text = user['level'] ?? '';
        _courseController.text = user['learnTopics']
                ?.map((item) => item['name'])
                ?.toList()
                .join(',') ??
            '';
        _scheduleController.text = user['schedule'] ?? '';
      });
    }
  }

  void _updateUserProfile() {}

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
            : Column(
                children: [
                  Stepper(
                    currentStep: _currentStep,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return const SizedBox();
                    },
                    steps: [
                      Step(
                        title: const Text('Hoàn thành hồ sơ'),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Cập nhật thông tin cá nhân'),
                        ),
                        state: _currentStep == 0
                            ? StepState.editing
                            : StepState.complete,
                        isActive: _currentStep == 0,
                      ),
                      Step(
                        title: const Text('Video giới thiệu'),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                              'Hãy để học viên biết những gì họ có thể mong đợi từ khoá học của bạn bằng việc quay lại video '
                              'điểm nhấn về việc dạy, chuyên môn và tính cách của bạn. Học viên có thể lo lắng khi nói chuyện '
                              'với người bản xứ, vì vậy sẽ thực sự hữu ích khi có một video thân thiện giới thiệu bản thân '
                              'và mời học viên gọi điện cho bạn.'),
                        ),
                        state: _currentStep == 1
                            ? StepState.editing
                            : StepState.complete,
                        isActive: _currentStep == 1,
                      ),
                      Step(
                        title: const Text('Phê duyệt'),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                              'Bạn đã hoàn thành đăng ký. Vui lòng đợi phê duyệt'),
                        ),
                        state: _currentStep == 2
                            ? StepState.editing
                            : StepState.complete,
                        isActive: _currentStep == 2,
                      ),
                    ],
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_currentStep < 2) {
                            _currentStep++;
                          } else {
                            _currentStep = 0;
                          }
                        });
                      },
                      child: const Text('Tiếp tục'),
                    ),
                  )
                ],
              ));
  }
}
