import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalState {
  late String lang;
  late String theme;

  GlobalState(this.lang, this.theme);
}

class GlobalStateCubit extends Cubit<GlobalState> {
  GlobalStateCubit(lang, theme)
      : super(GlobalState(lang ?? "vi", theme ?? 'light'));

  void changeLang(lang) => emit(GlobalState(lang, state.theme));

  void changeTheme(theme) => emit(GlobalState(state.lang, theme));
}
