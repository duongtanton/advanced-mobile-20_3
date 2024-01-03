import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/course_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseInfoPage extends StatefulWidget {
  const CourseInfoPage({super.key, required this.title});

  final String title;

  @override
  State<CourseInfoPage> createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  CourseService courseService = CourseService();
  var courseId = null;
  var course = null;
  var pages = 0;
  Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int? pagesPdf = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  bool loaded = false;
  String urlPDFPath = "";
  bool exists = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    await _getCourse();
  }

  _getCourse() async {
    if (courseId == null) {
      return;
    }
    var response = await courseService.getById(courseId);
    if (response['success']) {
      setState(() {
        course = response['data'];
      });
    }
  }

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  void _showTopic(BuildContext context, topic) async {
    await getFileFromUrl(topic["nameFile"])
        .then(
      (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Center(
                  child: Text(
                    topic["name"],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Mô tả: ${topic["description"]}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Text(
                      "Ngày tạo: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(topic["createdAt"]))}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Text(
                      "Ngày cập nhật: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(topic["updatedAt"]))}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    Text(
                      "Video hướng dẫn: ${topic["videoUrl"]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 300,
                        child: PDFView(
                          filePath: urlPDFPath,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: true,
                          pageFling: true,
                          pageSnap: true,
                          defaultPage: currentPage!,
                          fitPolicy: FitPolicy.BOTH,
                          preventLinkNavigation: false,
                          // if set to true the link is handled in flutter
                          onRender: (_pages) {
                            setState(() {
                              pagesPdf = _pages;
                              isReady = true;
                            });
                          },
                          onError: (error) {
                            setState(() {
                              errorMessage = error.toString();
                            });
                            print(error.toString());
                          },
                          onPageError: (page, error) {
                            setState(() {
                              errorMessage = '$page: ${error.toString()}';
                            });
                            print('$page: ${error.toString()}');
                          },
                          onViewCreated: (PDFViewController pdfViewController) {
                            _controller.complete(pdfViewController);
                          },
                          onLinkHandler: (String? uri) {
                            print('goto uri: $uri');
                          },
                          onPageChanged: (int? page, int? total) {
                            print('page change: $page/$total');
                            setState(() {
                              currentPage = page;
                            });
                          },
                        )),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }

  void requestPersmission() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    courseId =
        null != args && null != args['courseId'] ? args['courseId'] : null;
    Widget body;
    if (course != null) {
      var topics = course['topics'] ?? [];
      body = Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(course['imageUrl']),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(right: 20, bottom: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(course['description'],
                          style: const TextStyle(
                            fontSize: 14,
                          )),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    top: 4, right: 20, left: 20, bottom: 4)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent)),
                        child: const Text(
                          "Khám phá",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          const Text(
            "Tổng quan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text(
            "Tại sao bạn nên học khóa học này",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 16.0),
              maxLines: 100,
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black54, height: 1.5, fontSize: 14),
                  text: "    ${course['reason']}")),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const Text(
            "Bạn có thể làm gì",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(fontSize: 16.0),
              maxLines: 100,
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black54, height: 1.5, fontSize: 14),
                  text: "    ${course['purpose']}")),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            "Trình độ yêu cầu",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Text("     Intermediate",
              style: TextStyle(
                fontSize: 14,
              )),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            "Thời lượng khóa học",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text("     ${topics.length} chủ đề",
              style: const TextStyle(
                fontSize: 14,
              )),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            "Danh sách chủ đề",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          ...topics
              .asMap()
              .map((index, topic) => MapEntry(
                  index,
                  GestureDetector(
                    onTap: () {
                      _showTopic(context, topic);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          margin: const EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.grey[200]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Text("  ${index + 1}.   ${topic['name']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )))
              .values
              .toList()
        ]),
      );
    } else {
      body = Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return MainLayout(screen: "course_page", showNavigators: true, body: body);
  }
}
