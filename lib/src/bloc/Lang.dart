import 'package:flutter_bloc/flutter_bloc.dart';

class LangCubit extends Cubit<String> {
  LangCubit(lang) : super(lang ?? "vi");

  void change(lang) => emit(lang);
}
