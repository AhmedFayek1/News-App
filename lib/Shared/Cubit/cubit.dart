
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool IsDark = false;

  void ChangeMode({bool? fromshared}) {
    if (fromshared != null) {
      IsDark = fromshared;
      emit(ChangeAppModeState());
    }
    else {
      IsDark = !IsDark;
      //cache_helper.PutData(key: 'IsDark', value: IsDark).then((value) {
        emit(ChangeAppModeState());
      //});
    }
  }
}
