import 'package:bloc/bloc.dart';
import 'package:imdb_bloc/domain/event/main_event.dart';
import 'package:imdb_bloc/domain/state/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitial(0)) {
    on<MainEvent>((event, emit) {
      if (event is ChangeTabEvent) {
        emit(MainInitial(event.tabIndex));
      }
    });
  }
}
