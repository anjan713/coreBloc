import 'package:bloc_test/bloc_test.dart';
import 'package:coreBloc/logic/cubit/counter_cubit.dart';
import 'package:coreBloc/logic/cubit/counter_state.dart';
import 'package:test/test.dart';

void main() {
  group('counterGroup', () {
    CounterCubit counterCubit;
    setUp(() {
      //we use it to intialize the dependices for our test
      // counterCubit = CounterCubit();
    });
    tearDown(() {
      // as name suggest we use it to when the test is done close the stream
      counterCubit.close();
    });
    test('counterTest', () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });
    blocTest('test the increment',
        build: () => counterCubit,
        act: (cubit) => cubit.increment(),
        expect: [
          CounterState(counterValue: 1, isIncremented: true),
        ]);
    blocTest('test the decrement',
     build: ()=>counterCubit,
     act: (cubit2)=>cubit2.decrement(),
     expect: [CounterState(counterValue: -1,isIncremented: false)]);
  });
}
