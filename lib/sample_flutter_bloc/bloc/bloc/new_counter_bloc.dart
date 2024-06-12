import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_counter_event.dart';
part 'new_counter_state.dart';

class NewCounterBloc extends Bloc<NewCounterEvent, NewCounterState> {
  int value = 0;
  NewCounterBloc() : super(NewCounterSuccess(0)) {
    on<Increment>((event, emit) async {
      emit(NewCounterLoading());
      // delay 3 sec
      await Future.delayed(const Duration(seconds: 3));
      value++;
      // if (state is! NewCounterSuccess) {
      //   emit(NewCounterSuccess(1));
      //   return;
      // }
      // emit(NewCounterSuccess((state as NewCounterSuccess).counter + 1));
      emit(NewCounterSuccess(value));
    });

    on<Decrement>((event, emit) {
      emit(NewCounterLoading());
      value--;
      if (value <= -10) {
        value ++;
        emit(NewCounterFailure('Value Cannot be Less than -10'));
      } else {
        emit(NewCounterSuccess(value));
      }
    });
  }
}
