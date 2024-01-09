import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/utils/debug_print.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    AppPrint.debugPrint("BLOC CREATED $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    AppPrint.debugPrint("BLOC CHANGED ON BLOC $bloc ON CHANGE $change");
    super.onChange(bloc, change);
  }
}
