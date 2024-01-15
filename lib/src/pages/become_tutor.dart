import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/avatar.dart';
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
        body: Container(
          padding: const EdgeInsets.all(20),
          child: user == null
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
                    _currentStep == 0
                        ? Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.book,
                                        size: 90,
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 20)),
                                  Expanded(
                                    child: RichText(
                                      text: const TextSpan(
                                        text: "Thiết lập hồ sơ gia sư của bạn",
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    Expanded(
                                      child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              const StrutStyle(fontSize: 16.0),
                                          maxLines: 100,
                                          text: const TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  height: 1.5,
                                                  fontSize: 16),
                                              text:
                                                  "Hồ sơ gia sư của bạn là cơ hội "
                                                  "tiếp cận với học viên trên Tutoring."
                                                  " Bạn có thể sửa lại sau tại trang hồ sơ cá nhân.")),
                                    ),
                                  ],
                                ),
                              ),
                              Avatar(
                                url: user['avatar'] ?? '',
                                size: 150,
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Tên gia sư'),
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Tôi đến từ'),
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Ngày sinh'),
                              ),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Text("CV", style: TextStyle(fontSize: 30)),
                              Text(
                                  "Học viên sẽ xem thông tin từ hồ sơ của bạn để quyết định nếu bạn phù hợp với nhu cầu của họ."),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Sở thích'),
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Học Vấn'),
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Kinh nghiệm'),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    labelText:
                                        'Nghề nghiệp hiện tại hoặc trước đây '),
                              ),
                              Text("Về ngôn ngữ",
                                  style: TextStyle(fontSize: 30)),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Ngôn ngữ'),
                              ),
                              Text("Về giảng dạy",
                                  style: TextStyle(fontSize: 30)),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Giới thiệu'),
                              ),
                              Text(
                                  "Tôi giỏi nhất trong việc dạy những học viên"),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Chuyên ngành của tôi l'),
                              ),
                            ],
                          )
                        : _currentStep == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Avatar(
                                    url: user['avatar'] ?? '',
                                    size: 150,
                                  ),
                                  Text("Video giới thiệu",
                                      style: TextStyle(fontSize: 30)),
                                  Text("Một số mẹo hữu dụng: "),
                                  Text(
                                      "  1. Tìm một không gian trong lành và yên tĩnh"),
                                  Text(
                                      "  2. Cười thật tự nhiên, nhìn vào camera"),
                                  Text("  3. Ăn mặc lịch sự"),
                                  Text("  4. Nói trong 1-3 phút"),
                                  Text("  4. Brand yourself and have fun!"),
                                  Text(
                                    "Lưu ý: Chúng tôi chỉ hỗ trợ tải lên video có kích thước nhỏ hơn 64 MB.",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_currentStep < 2) {
                                          _currentStep++;
                                        } else {
                                          _currentStep = 0;
                                        }
                                      });
                                    },
                                    child: const Text('Chọn video'),
                                  ),
                                ],
                              )
                            : Container(),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_currentStep < 2) {
                              _currentStep++;
                            } else {
                              Navigator.pushNamed(context, '/');
                              //_currentStep = 0;
                            }
                          });
                        },
                        child: Text(_currentStep < 2
                            ? 'Tiếp tục'
                            : "Quay về trang chủ"),
                      ),
                    )
                  ],
                ),
        ));
  }
}
